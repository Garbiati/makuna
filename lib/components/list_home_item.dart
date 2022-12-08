import 'package:flutter/material.dart';
import '../utils/customWidgets.dart';
class ListHomeItem extends StatelessWidget {
  const ListHomeItem(
      {super.key,
      required this.path,
      required this.title,
      required this.subtitle,
      required this.route});

  final String path;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildSvgIcon(path),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
