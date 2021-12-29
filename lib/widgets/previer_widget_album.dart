import 'package:flutter/material.dart';

class PreviewWidgetAlbum extends StatelessWidget {
  final String image;
  final String title;

  const PreviewWidgetAlbum({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(image),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 12, right: 12),
                  child: Text(title),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
