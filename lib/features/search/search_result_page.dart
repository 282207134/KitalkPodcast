import 'package:flutter/material.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../show/show_page.dart';

/// Dark - Search Result: the query stays editable in the app bar field.
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.query});

  final String query;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late final TextEditingController _controller = TextEditingController(text: widget.query);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final matches = KtData.designResults
        .where((s) => '${s.title} ${s.artist}'.toLowerCase().contains(_controller.text.toLowerCase().trim()))
        .toList();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  const KtBackButton(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: p.surface, borderRadius: BorderRadius.circular(25)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _controller,
                        onChanged: (_) => setState(() {}),
                        cursorColor: p.accent,
                        style: TextStyle(fontSize: 16, color: p.onBackground),
                        decoration: const InputDecoration(isDense: true, border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: matches.isEmpty
                  ? Center(child: Text('No results', style: TextStyle(fontSize: 14, color: p.muted)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      itemCount: matches.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => KtShowTile(
                        matches[i],
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ShowPage(show: matches[i])),
                        ),
                        onMore: () => showEpisodeSheet(context, KtData.favouriteEpisodes[i % KtData.favouriteEpisodes.length]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
