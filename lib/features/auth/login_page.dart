import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../shell/kt_shell.dart';

/// Dark - Login.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const KtBackButton(),
              const SizedBox(height: 40),
              const KtScreenTitle('Login'),
              const SizedBox(height: 32),
              const KtField(label: 'Email', hint: 'ex. kitani@mail.com', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              const KtField(label: 'Password', hint: 'Input your password', obscure: true),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot Password?', style: TextStyle(fontSize: 14, color: p.accent)),
              ),
              const Spacer(),
              const KtSocialRow(),
              const SizedBox(height: 48),
              KtButton(
                label: 'Log in',
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const KtShell()),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
