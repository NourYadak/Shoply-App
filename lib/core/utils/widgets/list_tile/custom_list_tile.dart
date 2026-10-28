import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.iconData,
    this.color,
    this.onTap,
  });
  final String title;
  final IconData iconData;
  final Color? color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(iconData, size: 25, color: color ?? Colors.black),
      title: Text(title, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
