import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../data/catalog.dart';
import '../features/favourites/favourites_page.dart';
import '../features/home/home_page.dart';
import '../features/player/player_page.dart';
import '../features/profile/profile_page.dart';
import '../features/search/search_page.dart';
import '../state/app_store.dart';

/// Root of the four tabs plus the persistent mini player.
class KtShell extends StatefulWidget {
  const KtShell({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<KtShell> createState() => _KtShellState();
}

class _KtShellState extends State<KtShell> {
  late int _index = widget.initialTab;

  static const _pages = [HomePage(), SearchPage(), FavouritesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: _pages),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (store.showMiniPlayer) const KtMiniPlayer(),
          Container(
            color: p.background,
            child: SafeArea(
              top: false,
              child: KtBottomNav(index: _index, onChanged: (i) => setState(() => _index = i)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Home / Search / Favourite / Profile — the active item sits in a yellow tile.
class KtBottomNav extends StatelessWidget {
  const KtBottomNav({super.key, required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          _slot(0, Icons.home_outlined, Icons.home, p),
          _slot(1, Icons.search, Icons.search, p),
          _slot(2, Icons.star_outline_rounded, Icons.star_rounded, p),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(3),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: index == 3 ? p.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(KtData.avatar, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _slot(int i, IconData idle, IconData active, KtPalette p) {
    final selected = index == i;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(i),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: selected ? p.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              selected ? active : idle,
              size: 20,
              color: selected ? p.onAccent : p.muted,
            ),
          ),
        ),
      ),
    );
  }
}

/// Sticky "now playing" bar shown above the tab bar (Player Minimize screen).
class KtMiniPlayer extends StatelessWidget {
  const KtMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    final ep = store.current;
    return Column(
      children: [
        KtProgressBar(store.progress, height: 1.5),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlayerPage()),
          ),
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: p.background,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                KtCover(ep.cover, width: 40, height: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Episode ${ep.number}', style: TextStyle(fontSize: 10, color: p.accent)),
                      Text(ep.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                KtPlayToggle(size: 40, iconSize: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Circular play/pause control used by the mini player and the home card.
class KtPlayToggle extends StatelessWidget {
  const KtPlayToggle({super.key, this.size = 40, this.iconSize = 18});

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    return GestureDetector(
      onTap: store.togglePlay,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: p.onBackground, width: 2),
        ),
        child: Icon(
          store.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: iconSize,
          color: p.onBackground,
        ),
      ),
    );
  }
}
