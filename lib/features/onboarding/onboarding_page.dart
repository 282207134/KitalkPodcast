import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';

/// Dark - Onboarding: hero photo fading into the background, logo lockup, CTA pair.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/img/photo_hero.png', fit: BoxFit.cover, alignment: Alignment.topCenter),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [p.background.withValues(alpha: .35), p.background],
                stops: const [.25, .72],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 5),
                const KtLogo(size: 34, stack: true),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    'Listen your favourite podcast anywhere, anytime.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, height: 22 / 14, color: p.muted),
                  ),
                ),
                const Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    children: [
                      KtButton(
                        label: 'Sign up',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        ),
                      ),
                      const SizedBox(height: 16),
                      KtButton(
                        label: 'Log in',
                        outlined: true,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        ),
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
