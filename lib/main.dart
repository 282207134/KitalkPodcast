import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'features/onboarding/onboarding_page.dart';
import 'state/app_store.dart';

void main() => runApp(const KiTalkApp());

/// Root widget: owns the single [KtStore] and the light/dark theme pair.
class KiTalkApp extends StatelessWidget {
  const KiTalkApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => KtStore(),
        child: Consumer<KtStore>(
          builder: (_, store, _) => MaterialApp(
            title: 'KiTalk',
            debugShowCheckedModeBanner: false,
            theme: KtTheme.build(Brightness.light),
            darkTheme: KtTheme.build(Brightness.dark),
            themeMode: store.themeMode,
            home: const OnboardingPage(),
          ),
        ),
      );
}
