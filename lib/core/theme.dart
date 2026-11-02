import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Design tokens lifted from the KiTalk Pixso StyleGuide page.
///
/// Registered as a [ThemeExtension] so every screen reads colours through
/// `Theme.of(context).extension<KtPalette>()` instead of branching on brightness.
@immutable
class KtPalette extends ThemeExtension<KtPalette> {
  const KtPalette({
    required this.isDark,
    required this.background,
    required this.surface,
    required this.onBackground,
    required this.muted,
    required this.faint,
    required this.accent,
    required this.onAccent,
    required this.divider,
  });

  final bool isDark;
  final Color background;
  final Color surface;
  final Color onBackground;
  final Color muted;
  final Color faint;
  final Color accent;
  final Color onAccent;
  final Color divider;

  static const Color black = Color(0xFF131311);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF9F9F9);
  static const Color yellow = Color(0xFFFFED5F);

  static const KtPalette dark = KtPalette(
    isDark: true,
    background: black,
    surface: Color(0xFF1D1D1B),
    onBackground: white,
    muted: Color(0x66FFFFFF),
    faint: Color(0x1AFFFFFF),
    accent: yellow,
    onAccent: black,
    divider: Color(0x14FFFFFF),
  );

  static const KtPalette light = KtPalette(
    isDark: false,
    background: offWhite,
    surface: white,
    onBackground: black,
    muted: Color(0x66131311),
    faint: Color(0x0D131311),
    accent: yellow,
    onAccent: black,
    divider: Color(0x14131311),
  );

  @override
  KtPalette copyWith({bool? isDark}) => KtPalette(
        isDark: isDark ?? this.isDark,
        background: background,
        surface: surface,
        onBackground: onBackground,
        muted: muted,
        faint: faint,
        accent: accent,
        onAccent: onAccent,
        divider: divider,
      );

  @override
  KtPalette lerp(ThemeExtension<KtPalette>? other, double t) => this;
}

/// Shorthand for the active palette: `pal(context).accent`.
KtPalette pal(BuildContext context) =>
    Theme.of(context).extension<KtPalette>()!;

class KtTheme {
  const KtTheme._();

  static const String font = 'Poppins';

  static ThemeData build(Brightness brightness) {
    final p = brightness == Brightness.dark ? KtPalette.dark : KtPalette.light;
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: font,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KtPalette.yellow,
        brightness: brightness,
        primary: p.accent,
        onPrimary: p.onAccent,
        surface: p.background,
        onSurface: p.onBackground,
      ),
      scaffoldBackgroundColor: p.background,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: [p],
    );
    return base.copyWith(
      textTheme: TextTheme(
        displaySmall: _s(p, 21, FontWeight.bold),
        titleLarge: _s(p, 18, FontWeight.bold),
        titleMedium: _s(p, 16, FontWeight.w600),
        bodyLarge: _s(p, 14, FontWeight.w500),
        bodyMedium: _s(p, 14, FontWeight.w400),
        bodySmall: _s(p, 12, FontWeight.w400, p.muted),
        labelLarge: _s(p, 14, FontWeight.w600),
        labelMedium: _s(p, 12, FontWeight.w400, p.muted),
        labelSmall: _s(p, 10, FontWeight.w400, p.muted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.onBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: _s(p, 21, FontWeight.w500),
      ),
      iconTheme: IconThemeData(color: p.onBackground),
      dividerTheme: DividerThemeData(color: p.divider, thickness: 1, space: 1),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.background : p.onBackground,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.accent : p.faint,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.background,
        surfaceTintColor: Colors.transparent,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextStyle _s(
    KtPalette p,
    double size,
    FontWeight weight, [
    Color? color,
  ]) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        height: (size + 6) / size,
        color: color ?? p.onBackground,
      );
}
