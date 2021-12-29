import 'package:flutter/material.dart';

class CompanyItemWidget extends StatelessWidget {
  final String type;
  final String value;

  const CompanyItemWidget({Key? key, required this.type, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$type:',
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
