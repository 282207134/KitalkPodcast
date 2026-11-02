import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../core/widgets.dart';
import '../../data/catalog.dart';
import '../../state/app_store.dart';

/// Dark - Edit Profile: identity fields with the yellow "validated" tick.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final KtStore _store = context.read<KtStore>();
  late final Map<String, String> _draft = {
    'Name': _store.name,
    'Email': _store.email,
    'Phone Number': _store.phone,
  };

  void _save() {
    _store.saveProfile(
      name: _draft['Name'],
      email: _draft['Email'],
      phone: _draft['Phone Number'],
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Scaffold(
      appBar: AppBar(
        leading: const KtBackButton(),
        title: const Text('Edit Profile'),
        actions: [
          GestureDetector(
            onTap: _save,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                  child: Text('Save',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: p.accent))),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          Row(
            children: [
              ClipOval(
                  child: Image.asset(KtData.avatar, width: 64, height: 64, fit: BoxFit.cover)),
              const SizedBox(width: 20),
              const _UploadPhoto(),
            ],
          ),
          const SizedBox(height: 40),
          for (final entry in _draft.entries) ...[
            KtField(
              label: entry.key,
              initial: entry.value,
              suffix: Icon(Icons.check, size: 20, color: p.accent),
              onChanged: (v) => _draft[entry.key] = v,
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _UploadPhoto extends StatelessWidget {
  const _UploadPhoto();

  @override
  Widget build(BuildContext context) {
    final p = pal(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: p.muted),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_camera_outlined, size: 20, color: p.onBackground),
          const SizedBox(width: 10),
          Text('Upload Photo', style: TextStyle(fontSize: 16, color: p.muted)),
        ],
      ),
    );
  }
}
