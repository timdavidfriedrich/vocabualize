import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';

class SettingsListTile extends StatelessWidget {
  final Text title;
  final Text? subtitle;
  final Widget? trailing;

  const SettingsListTile({super.key, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: title,
      subtitle: subtitle?.data?.let((data) {
        return Text(data, style: TextStyle(color: Theme.of(context).hintColor));
      }),
      trailing: trailing,
    );
  }
}
