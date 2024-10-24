import 'package:flutter/material.dart';
import 'package:watch_flow/generated/l10n.dart';

class build_tablet extends StatelessWidget {
  const build_tablet({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });
  final String title;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
