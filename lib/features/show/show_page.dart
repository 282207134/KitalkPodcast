import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../data/models.dart';
import '../../state/app_store.dart';

/// Dark - Artist Playlist: show header over a blurred backdrop, then the episode list.
class ShowPage extends StatelessWidget {
  const ShowPage({super.key, this.show});

  final Show? show;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final s = show ?? KtData.fearlessTalks;
    final episodes = s.episodes.isEmpty ? KtData.fearlessTalks.episodes : s.episodes;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Align(alignment: Alignment.centerLeft, child: KtBackButton()),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _ShowHeader(show: s),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Text.rich(
                      TextSpan(
                        text: s.about,
                        style: TextStyle(fontSize: 12, height: 18 / 12, color: p.muted),
                        children: [
                          TextSpan(
                            text: 'see more',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: p.onBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('All Episodes', style: Theme.of(context).textTheme.titleLarge),
                        Row(
                          children: [
                            Text('Newest', style: TextStyle(fontSize: 14, color: p.muted)),
                            const SizedBox(width: 6),
                            Icon(Icons.keyboard_arrow_down, color: p.muted),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: Column(
                      children: [
                        for (final e in episodes)
                          KtEpisodeTile(
                            e,
                            onTap: () => context.read<KtStore>().play(e),
                            onMore: () => showEpisodeSheet(context, e),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowHeader extends StatelessWidget {
  const _ShowHeader({required this.show});

  final Show show;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SizedBox(
      height: 190,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(show.backdrop, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [p.background.withValues(alpha: .55), p.background],
                  stops: const [.45, 1],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KtCover(show.cover, width: 100, height: 100, radius: 4),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        Text(show.title, style: Theme.of(context).textTheme.displaySmall),
                        const SizedBox(height: 12),
                        Text(show.artist, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
