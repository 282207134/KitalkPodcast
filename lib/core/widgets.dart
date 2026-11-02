import 'package:flutter/material.dart';

import '../data/models.dart';
import 'theme.dart';

/// Rounded artwork used for covers, backdrops and category tiles.
class KtCover extends StatelessWidget {
  const KtCover(this.src, {super.key, this.radius = 8, this.width, this.height, this.fit = BoxFit.cover});

  final String src;
  final double radius;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(src, width: width, height: height, fit: fit),
      );
}

/// The solid-yellow / outlined pill buttons from the StyleGuide.
class KtButton extends StatelessWidget {
  const KtButton({
    super.key,
    required this.label,
    this.onTap,
    this.outlined = false,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onTap;
  final bool outlined;
  final double height;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: outlined ? Colors.transparent : p.accent,
          foregroundColor: outlined ? p.onBackground : p.onAccent,
          side: outlined ? BorderSide(color: p.muted) : null,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

/// Labelled text field used across Login / Sign up / Edit Profile.
class KtField extends StatelessWidget {
  const KtField({
    super.key,
    required this.label,
    this.hint,
    this.initial,
    this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final String? hint;
  final String? initial;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: p.muted)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initial,
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorColor: p.accent,
          style: TextStyle(fontSize: 16, color: p.onBackground),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16, color: p.muted),
            suffixIcon: suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: suffix,
                  ),
            suffixIconConstraints: const BoxConstraints(),
            enabledBorder: _border(p, p.muted),
            focusedBorder: _border(p, p.accent),
            border: _border(p, p.muted),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(KtPalette p, Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: color),
      );
}

/// Section title with an optional trailing action ("Top Categories / View All").
class KtSectionHeader extends StatelessWidget {
  const KtSectionHeader(this.title, {super.key, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              child: Text(action!, style: TextStyle(fontSize: 12, color: p.muted)),
            ),
        ],
      ),
    );
  }
}

/// Three-dot affordance shared by every list row.
class KtMoreButton extends StatelessWidget {
  const KtMoreButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        icon: const Icon(Icons.more_vert, size: 20),
      );
}

/// Square podcast card used in the horizontal rails on Home / Category.
class KtShowCard extends StatelessWidget {
  const KtShowCard(this.show, {super.key, this.onTap});

  final Show show;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SizedBox(
      width: 112,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KtCover(show.cover, width: 112, height: 112),
            const SizedBox(height: 8),
            Text(show.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
            Text(show.artist, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: p.muted)),
          ],
        ),
      ),
    );
  }
}

/// Card variant that leads with a yellow "Episode N" label.
class KtEpisodeCard extends StatelessWidget {
  const KtEpisodeCard(this.episode, {super.key, this.onTap});

  final Episode episode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return SizedBox(
      width: 112,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KtCover(episode.cover, width: 112, height: 112),
            const SizedBox(height: 8),
            Text('Episode ${episode.number}', style: TextStyle(fontSize: 10, color: p.accent)),
            const SizedBox(height: 2),
            Text(episode.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(episode.showTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: p.muted)),
          ],
        ),
      ),
    );
  }
}

/// Full-width episode row: thumb, yellow episode label, title and description.
class KtEpisodeTile extends StatelessWidget {
  const KtEpisodeTile(this.episode, {super.key, this.onTap, this.onMore, this.showDescription = true});

  final Episode episode;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KtCover(episode.cover, width: 48, height: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Episode ${episode.number}', style: TextStyle(fontSize: 10, color: p.accent)),
                      const SizedBox(height: 2),
                      Text(episode.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                KtMoreButton(onTap: onMore),
              ],
            ),
            if (showDescription) ...[
              const SizedBox(height: 10),
              Text(episode.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, height: 18 / 11, color: p.muted)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Compact show row used by Search results and the Favourite / Shows tab.
class KtShowTile extends StatelessWidget {
  const KtShowTile(this.show, {super.key, this.onTap, this.onMore, this.trailing});

  final Show show;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            KtCover(show.cover, width: 48, height: 48),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(show.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(show.artist, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: p.muted)),
                ],
              ),
            ),
            trailing ?? KtMoreButton(onTap: onMore),
          ],
        ),
      ),
    );
  }
}

/// Thin yellow progress bar shared by the player, mini player and home card.
class KtProgressBar extends StatelessWidget {
  const KtProgressBar(this.value, {super.key, this.height = 2});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: p.faint,
        valueColor: AlwaysStoppedAnimation(p.accent),
      ),
    );
  }
}

/// KiTalk wordmark: yellow glyph + Poppins Bold text.
class KtLogo extends StatelessWidget {
  const KtLogo({super.key, this.size = 22, this.stack = false});

  final double size;
  final bool stack;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final wordmark = Text('Kitalk',
        style: TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: p.onBackground, height: 1.2));
    final mark = Image.asset('assets/img/logo_mark.png', height: stack ? size * 2.6 : size * 1.2);
    return stack
        ? Column(mainAxisSize: MainAxisSize.min, children: [mark, const SizedBox(height: 12), wordmark])
        : Row(mainAxisSize: MainAxisSize.min, children: [mark, const SizedBox(width: 6), wordmark]);
  }
}

/// Standard back affordance used by every pushed screen.
class KtBackButton extends StatelessWidget {
  const KtBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onTap ?? () => Navigator.of(context).maybePop(),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        icon: const Icon(Icons.arrow_back, size: 22),
      );
}

/// Left-aligned screen title ("Login", "Search", "My Favourite").
class KtScreenTitle extends StatelessWidget {
  const KtScreenTitle(this.title, {super.key, this.style});

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: style ??
            Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
      );
}

/// Google / Facebook chips on the auth screens.
class KtSocialButton extends StatelessWidget {
  const KtSocialButton({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: p.surface, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

/// "or continue with" caption plus the two provider chips.
class KtSocialRow extends StatelessWidget {
  const KtSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('or continue with', style: TextStyle(fontSize: 14, color: p.muted)),
        const SizedBox(height: 16),
        Row(
          children: [
            KtSocialButton(
              child: Image.asset('assets/img/ic_google.png', width: 22),
            ),
            const SizedBox(width: 16),
            KtSocialButton(
              child: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 22),
            ),
          ],
        ),
      ],
    );
  }
}
