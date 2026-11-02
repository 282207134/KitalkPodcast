import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/sheets.dart';
import '../../core/theme.dart';
import '../../data/catalog.dart';
import '../../state/app_store.dart';
import '../subscription/subscription_page.dart';
import 'edit_profile_page.dart';

/// Dark - Profile: identity, premium CTA and the settings list.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    final store = context.watch<KtStore>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        const Text('Profile',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 28),
        Row(
          children: [
            ClipOval(
                child: Image.asset(KtData.avatar, width: 64, height: 64, fit: BoxFit.cover)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const EditProfilePage())),
                    child: Text('Edit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: p.accent)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        if (store.premium)
          const _PremiumBanner('PREMIUM ACTIVE')
        else
          _PremiumBanner('JOIN PREMIUM NOW',
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SubscriptionPage()))),
        const SizedBox(height: 28),
        const _Group('Subscription'),
        _Row('Manage Subscription', onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SubscriptionPage()))),
        _Row('History'),
        const _Group('App Settings'),
        _Row('Streaming Quality',
            value: store.quality.name[0].toUpperCase() + store.quality.name.substring(1),
            onTap: () => showQualitySheet(context)),
        _Row('Language', value: store.language),
        _Row('Notification', trailing: Switch(
          value: store.notifications,
          onChanged: store.setNotifications,
        )),
        _Row('Theme', trailing: Switch(
          value: p.isDark,
          onChanged: (_) => store.toggleTheme(),
        )),
        _Row('Help Center'),
        _Row('Log Out', onTap: () => Navigator.of(context).popUntil((r) => r.isFirst)),
      ],
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  const _PremiumBanner(this.label, {this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: p.accent.withValues(alpha: p.isDark ? .12 : .28),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: p.accent),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: p.accent)),
            ),
            if (onTap != null) Icon(Icons.chevron_right, color: p.accent),
          ],
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: pal(context).muted)),
      );
}

class _Row extends StatelessWidget {
  const _Row(this.label, {this.value, this.onTap, this.trailing});

  final String label;
  final String? value;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Column(
      children: [
        SizedBox(
          height: 56,
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Expanded(
                    child: Text(label, style: const TextStyle(fontSize: 16))),
                if (value != null)
                  Text(value!, style: TextStyle(fontSize: 16, color: p.accent)),
                trailing ??
                    (onTap == null
                        ? const SizedBox.shrink()
                        : Icon(Icons.chevron_right, size: 20, color: p.accent)),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: p.divider),
      ],
    );
  }
}
