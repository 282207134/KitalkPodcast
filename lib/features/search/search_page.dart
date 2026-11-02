import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../data/models.dart';
import '../category/category_page.dart';
import 'search_result_page.dart';

/// Dark - Search: query field plus the two-column category masonry.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SearchResultPage(query: q)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        const KtScreenTitle('Search'),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: p.surface, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Icon(Icons.search, color: p.accent, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _submit(),
                        cursorColor: p.accent,
                        style: TextStyle(fontSize: 14, color: p.onBackground),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Search Podcast',
                          hintStyle: TextStyle(fontSize: 14, color: p.muted),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: p.accent)),
            ),
          ],
        ),
        const KtSectionHeader('Categories'),
        const _CategoryMasonry(),
      ],
    );
  }
}

class _CategoryMasonry extends StatelessWidget {
  const _CategoryMasonry();

  @override
  Widget build(BuildContext context) {
    final left = KtData.browseCategories.where((c) => c.column == 0).toList();
    final right = KtData.browseCategories.where((c) => c.column == 1).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _column(left)),
        const SizedBox(width: 16),
        Expanded(child: _column(right)),
      ],
    );
  }

  Widget _column(List<BrowseCategory> items) => Column(
        children: [
          for (final c in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _CategoryTile(c),
            ),
        ],
      );
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile(this.category);

  final BrowseCategory category;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CategoryPage(category: category)),
      ),
      child: Container(
        height: category.tall ? 209 : 97,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: p.surface),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(category.image, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xB3000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  if (category.subtitle != null)
                    Text(category.subtitle!,
                        style: const TextStyle(fontSize: 14, color: Color(0xCCFFFFFF))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
