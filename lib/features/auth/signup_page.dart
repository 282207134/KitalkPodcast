import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../shell/kt_shell.dart';

/// Dark - Sign up.
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: KtBackButton(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const KtScreenTitle('Sign up'),
                    const SizedBox(height: 16),
                    Text(
                      'Enter information below or login with social account to get started',
                      style: TextStyle(fontSize: 14, height: 24 / 14, color: p.muted),
                    ),
                    const SizedBox(height: 32),
                    const KtField(label: 'Email', hint: 'ex. kitani@mail.com', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 24),
                    const KtField(label: 'Password', hint: 'Input your password', obscure: true),
                    const SizedBox(height: 24),
                    const KtField(label: 'Confirmation Password', hint: 'Input your password', obscure: true),
                    const SizedBox(height: 40),
                    const KtSocialRow(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: KtButton(
                label: 'Sign up',
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const KtShell()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
