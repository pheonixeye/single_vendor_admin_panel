import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    required this.title,
    required this.actions,
    this.leading,
  });
  final Widget title;
  final List<Widget> actions;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: true,
      centerTitle: true,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
