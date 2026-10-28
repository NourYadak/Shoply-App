import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
    this.actionsPadding,
    this.leading,
  });
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsetsGeometry? actionsPadding;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: actionsPadding,
      actions: actions,
      leading: leading,
      title:
          title ??
          Text(titleText ?? '', style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
