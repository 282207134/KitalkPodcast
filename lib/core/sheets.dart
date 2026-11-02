import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models.dart';
import '../state/app_store.dart';
import 'theme.dart';
import 'widgets.dart';

/// Dark - Modal Dialogue: the iOS sheet pattern used by every picker in KiTalk.
Future<T?> showKtSheet<T>(BuildContext context, {required String title, required List<Widget> children}) =>
    showModalBottomSheet<T>(
      context: context,
      backgroundColor: pal(context).background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(color: pal(ctx).faint, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 24),
              Text(title, style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...children,
            ],
          ),
        ),
      ),
    );

/// Single-select picker with the yellow tick and a confirming Save button.
class KtChoiceOption extends StatelessWidget {
  const KtChoiceOption({super.key, required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(label, style: const TextStyle(fontSize: 16)),
      trailing: selected ? Icon(Icons.check, color: p.accent) : null,
    );
  }
}

/// "Stream Quality" sheet from the Profile screen.
Future<void> showQualitySheet(BuildContext context) async {
  final store = context.read<KtStore>();
  var draft = store.quality;
  await showKtSheet<void>(
    context,
    title: 'Stream Quality',
    children: [
      StatefulBuilder(
        builder: (ctx, setState) => Column(
          children: [
            for (final q in StreamQuality.values)
              KtChoiceOption(
                label: q.name[0].toUpperCase() + q.name.substring(1),
                selected: draft == q,
                onTap: () => setState(() => draft = q),
              ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      KtButton(
        label: 'Save',
        onTap: () {
          store.setQuality(draft);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

/// Row-level actions for an episode.
Future<void> showEpisodeSheet(BuildContext context, Episode episode) => showKtSheet<void>(
      context,
      title: episode.title,
      children: [
        StatefulBuilder(
          builder: (ctx, setState) {
            final store = ctx.read<KtStore>();
            final fav = store.isFavouriteEpisode(episode.id);
            return Column(
              children: [
                KtChoiceOption(
                  label: fav ? 'Remove from Favourites' : 'Add to Favourites',
                  selected: fav,
                  onTap: () {
                    store.toggleFavouriteEpisode(episode.id);
                    setState(() {});
                  },
                ),
                KtChoiceOption(
                  label: 'Play next',
                  selected: false,
                  onTap: () => Navigator.of(ctx).pop(),
                ),
              ],
            );
          },
        ),
      ],
    );
