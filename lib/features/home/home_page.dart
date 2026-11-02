import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../data/models.dart';
import '../../state/app_store.dart';
import '../player/player_page.dart';
import '../show/show_page.dart';
import '../subscription/subscription_page.dart';

/// Dark - Home: premium banner, continue listening, two rails and category chips.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final continuing = [KtData.continueListening, ...KtData.newEpisodes];
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: KtLogo(),
        ),
        const _PremiumBanner(),
        const KtSectionHeader('Continue Listening'),
        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: continuing.length,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (_, i) => _ContinueCard(
              episode: continuing[i],
              onTap: () {
                context.read<KtStore>().play(continuing[i]);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PlayerPage()),
                );
              },
            ),
          ),
        ),
        const KtSectionHeader('Make you laugh'),
        _ShowRail(KtData.laughRow),
        const KtSectionHeader('New Episode'),
        SizedBox(
          height: 198,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: KtData.newEpisodes.length,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (_, i) => KtEpisodeCard(
              KtData.newEpisodes[i],
              onTap: () => context.read<KtStore>().play(KtData.newEpisodes[i]),
            ),
          ),
        ),
        KtSectionHeader('Top Categories', action: 'View All'),
        const _CategoryGrid(),
      ],
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  const _PremiumBanner();

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 138,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFD9A400), Color(0xFFB8860B)],
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset('assets/img/photo_hero.png', width: 150, height: 138, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Try premium 1 month trial',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: p.isDark ? Colors.white : KtPalette.black),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SubscriptionPage()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                            decoration:
                                BoxDecoration(color: KtPalette.yellow, borderRadius: BorderRadius.circular(20)),
                            child: const Text('Try Now',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: KtPalette.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // The hero photo occupies the right edge of the banner.
                  const SizedBox(width: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wide blurred-backdrop card used by the Continue Listening rail.
class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.episode, required this.onTap});

  final Episode episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 297,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: p.surface),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/img/bg_continue.png', fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(.35)),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [p.background.withValues(alpha: .92), p.background.withValues(alpha: .45)],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${episode.showTitle} by ${episode.showArtist}', style: TextStyle(fontSize: 12, color: p.muted)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      KtCover(episode.cover, width: 40, height: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Episode ${episode.number}', style: TextStyle(fontSize: 10, color: p.accent)),
                            Text(episode.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  KtProgressBar(episode.progress),
                  const SizedBox(height: 8),
                  Text('${episode.minutesLeft} min. remaining', style: TextStyle(fontSize: 12, color: p.muted)),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 16,
              child: GestureDetector(
                onTap: () => context.read<KtStore>().play(episode),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow_rounded, size: 18, color: KtPalette.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowRail extends StatelessWidget {
  const _ShowRail(this.shows);

  final List<Show> shows;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 163,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: shows.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (_, i) => KtShowCard(
            shows[i],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ShowPage()),
            ),
          ),
        ),
      );
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  static const _icons = [
    Icons.bar_chart_rounded,
    Icons.mic_none_rounded,
    Icons.star_outline_rounded,
    Icons.videocam_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 156 / 55,
        children: [
          for (var i = 0; i < KtData.homeCategoryTiles.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: p.surface, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(_icons[i], size: 20, color: p.muted),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(KtData.homeCategoryTiles[i],
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
