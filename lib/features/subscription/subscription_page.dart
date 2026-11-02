import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../state/app_store.dart';

/// Dark - Subscription: the premium upsell with the monthly / yearly choice.
class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _plan = 0;

  static const List<(String, String, String?)> _plans = [
    ('Monthly', r'$3.50', null),
    ('Yearly', r'$30.00', r'save $12'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 420,
            child: KtCover(KtData.premiumBackdrop, radius: 0, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: EdgeInsets.only(left: 12), child: KtBackButton()),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
                    children: [
                      Center(child: Image.asset('assets/img/logo_mark.png', height: 88)),
                      const SizedBox(height: 28),
                      const Center(
                        child: Text('Go Premium',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Join Premium now to get unlimited listen to your favourite podcast without ads',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, height: 26 / 16, color: p.muted),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          for (var i = 0; i < _plans.length; i++) ...[
                            if (i > 0) const SizedBox(width: 16),
                            Expanded(
                              child: _PlanCard(
                                label: _plans[i].$1,
                                price: _plans[i].$2,
                                note: _plans[i].$3,
                                selected: _plan == i,
                                onTap: () => setState(() => _plan = i),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                          child: Text('Recurring billing. Cancel anytime',
                              style: TextStyle(fontSize: 14, color: p.muted))),
                      const SizedBox(height: 40),
                      KtButton(
                        label: 'Go Premium',
                        onTap: () {
                          context.read<KtStore>().goPremium();
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 32),
                      _Legal(p),
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

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.label,
    required this.price,
    required this.selected,
    required this.onTap,
    this.note,
  });

  final String label;
  final String price;
  final String? note;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: p.surface.withValues(alpha: .55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? p.accent : p.muted, width: selected ? 2 : 1),
        ),
        child: Stack(
          children: [
            if (selected)
              Positioned(top: 14, right: 14, child: Icon(Icons.check, size: 20, color: p.accent)),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: TextStyle(fontSize: 16, color: p.muted)),
                  if (note != null) ...[
                    const SizedBox(height: 2),
                    Text(note!, style: TextStyle(fontSize: 12, color: p.muted)),
                  ],
                  const SizedBox(height: 14),
                  Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The iTunes / manage / terms paragraph block.
class _Legal extends StatelessWidget {
  const _Legal(this.p);

  final KtPalette p;

  @override
  Widget build(BuildContext context) {
    final body = TextStyle(fontSize: 16, height: 26 / 16, color: p.muted);
    final strong = body.copyWith(color: p.onBackground);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subscription will be charged via your iTunes Account.', style: body),
        const SizedBox(height: 12),
        Text('You can manage your subscription in Profile.', style: body),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(text: 'By going premium, you agree to the ', style: body, children: [
            TextSpan(text: 'Terms of Service ', style: strong),
            TextSpan(text: 'and ', style: body),
            TextSpan(text: 'Privacy Policy', style: strong),
          ]),
        ),
      ],
    );
  }
}
