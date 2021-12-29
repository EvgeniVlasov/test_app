import 'package:flutter/material.dart';

class AppBarTestApp extends StatefulWidget {
  final String title;
  final Widget body;

  const AppBarTestApp({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  _AppBarTestAppState createState() => _AppBarTestAppState();
}

class _AppBarTestAppState extends State<AppBarTestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      body: widget.body,
    );
  }
}
