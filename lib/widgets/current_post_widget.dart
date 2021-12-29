import 'package:flutter/material.dart';

class CurrentPostWidget extends StatelessWidget {
  const CurrentPostWidget({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(body, style: Theme.of(context).textTheme.subtitle1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
