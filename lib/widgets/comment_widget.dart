import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String email;
  final String name;
  final String body;
  const CommentWidget({Key? key,required this.email,required this.name,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              email,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(body,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
