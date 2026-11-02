import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../state/app_store.dart';

/// Dark - Player: full-bleed blurred artwork, scrubber and transport controls.
class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (mounted) context.read<KtStore>().tick();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    final ep = store.current;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ep.cover, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [p.background.withValues(alpha: .82), p.background],
                stops: const [.2, .75],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.keyboard_arrow_down, size: 26),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KtCover(ep.cover, width: 250, height: 250, radius: 8),
                      const SizedBox(height: 28),
                      Text(ep.showTitle, style: TextStyle(fontSize: 16, color: p.muted)),
                      const SizedBox(height: 36),
                      Text('Episode ${ep.number}', style: TextStyle(fontSize: 16, color: p.accent)),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          ep.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _Scrubber(value: store.progress, onChanged: store.seek),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.picture_in_picture_alt_rounded, color: p.muted, size: 24),
                      _Transport(Icons.skip_previous, () => store.skip(-1)),
                      GestureDetector(
                        onTap: store.togglePlay,
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: p.onBackground, width: 3),
                          ),
                          child: Icon(
                            store.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            size: 34,
                          ),
                        ),
                      ),
                      _Transport(Icons.skip_next, () => store.skip(1)),
                      IconButton(
                        onPressed: () => showEpisodeSheet(context, ep),
                        icon: const Icon(Icons.more_vert, size: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Transport extends StatelessWidget {
  const _Transport(this.icon, this.onTap);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap,
        iconSize: 30,
        icon: Icon(icon),
      );
}

class _Scrubber extends StatelessWidget {
  const _Scrubber({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        activeTrackColor: p.accent,
        inactiveTrackColor: p.faint,
        thumbColor: p.accent,
        overlayColor: p.accent.withValues(alpha: .18),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      ),
      child: Slider(value: value.clamp(0, 1), onChanged: onChanged),
    );
  }
}
