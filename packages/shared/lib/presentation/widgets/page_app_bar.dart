import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const PageAppBar({
  super.key,
  final Widget? _title,
  final bool _closes = false,
  final List<Widget> _actions = const [],
}) extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleTextStyle: context.t.headlineSmall,
      leading: _closes
          ? IconButton(
              onPressed: context.closeScreen,
              tooltip: context.s.close,
              icon: const Icon(Icons.close_rounded),
            )
          : null,
      title: _title,
      actions: _actions,
    );
  }
}
