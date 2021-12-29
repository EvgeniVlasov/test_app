import 'package:flutter/material.dart';

class ItemWidgetCard extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;

  const ItemWidgetCard(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
