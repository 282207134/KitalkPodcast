import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../data/models.dart';
import '../../state/app_store.dart';
import '../show/show_page.dart';

/// Dark - Favourite: two tabs over the saved episodes and shows.
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    final episodes = KtData.favouriteEpisodes.where((e) => store.isFavouriteEpisode(e.id)).toList();
    final shows = KtData.designResults.where((s) => store.isFavouriteShow(s.id)).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        const KtScreenTitle('My Favourite'),
        const SizedBox(height: 24),
        Row(
          children: [
            _Pill('Recent Episodes', active: _tab == 0, onTap: () => setState(() => _tab = 0)),
            const SizedBox(width: 12),
            _Pill('Shows', active: _tab == 1, onTap: () => setState(() => _tab = 1)),
          ],
        ),
        const SizedBox(height: 24),
        if (_tab == 0)
          ...[
            for (final group in _splitByPlayed(episodes)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(group.$1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: p.muted)),
              ),
              for (final e in group.$2)
                KtEpisodeTile(e, onTap: () => store.play(e), onMore: () => showEpisodeSheet(context, e)),
            ],
            if (episodes.isEmpty) _empty(p),
          ]
        else ...[
          for (final s in shows)
            KtShowTile(
              s,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ShowPage(show: s)),
              ),
              onMore: () => store.toggleFavouriteShow(s.id),
            ),
          if (shows.isEmpty) _empty(p),
        ],
      ],
    );
  }

  Widget _empty(KtPalette p) => Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Center(child: Text('Nothing saved yet', style: TextStyle(fontSize: 14, color: p.muted))),
      );
}

/// The design groups the saved episodes under "This week" then "Unplayed".
List<(String, List<Episode>)> _splitByPlayed(List<Episode> items) {
  final week = items.take(2).toList();
  final rest = items.length > week.length ? items.sublist(week.length) : const <Episode>[];
  return [('This week', week), ('Unplayed', rest)].where((g) => g.$2.isNotEmpty).toList();
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, {required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: active ? Colors.transparent : p.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? p.accent : Colors.transparent),
        ),
        child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
