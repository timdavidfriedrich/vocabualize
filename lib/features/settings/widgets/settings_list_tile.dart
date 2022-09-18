import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.title, this.subtitle, this.trailing});

  final Text title;
  final Text? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: title,
      subtitle: subtitle == null ? null : Text(subtitle!.data!, style: TextStyle(color: Theme.of(context).hintColor)),
      trailing: trailing,
    );
  }
}
