import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String value;
  final String type;

  const InfoWidget({Key? key, required this.type, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w400, color: Colors.white),
          )
        ],
      ),
    );
  }
}
