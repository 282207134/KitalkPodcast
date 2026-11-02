import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../data/models.dart';
import '../../state/app_store.dart';
import '../show/show_page.dart';

/// Dark - Categories: a single browse category ("Educational") with three rails.
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.category});

  final BrowseCategory category;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      appBar: AppBar(
        leading: const KtBackButton(),
        title: Text(category.name),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const KtSectionHeader('Popular'),
            SizedBox(
              height: 163,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: KtData.educationalPopular.length,
                separatorBuilder: (_, _) => const SizedBox(width: 20),
                itemBuilder: (_, i) => KtShowCard(
                  KtData.educationalPopular[i],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ShowPage(show: KtData.educationalPopular[i])),
                  ),
                ),
              ),
            ),
            const KtSectionHeader('Trending Episode'),
            SizedBox(
              height: 198,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: KtData.newEpisodes.length,
                separatorBuilder: (_, _) => const SizedBox(width: 20),
                itemBuilder: (_, i) => KtEpisodeCard(
                  KtData.newEpisodes[i],
                  onTap: () => context.read<KtStore>().play(KtData.newEpisodes[i]),
                ),
              ),
            ),
            const KtSectionHeader('Talking about Science'),
            for (final e in KtData.fearlessTalks.episodes)
              KtEpisodeTile(
                e,
                onTap: () => context.read<KtStore>().play(e),
                onMore: () => showEpisodeSheet(context, e),
              ),
            const SizedBox(height: 8),
            Text('Showing all ${KtData.fearlessTalks.episodes.length} episodes',
                style: TextStyle(fontSize: 12, color: p.muted)),
          ],
        ),
      ),
    );
  }
}
