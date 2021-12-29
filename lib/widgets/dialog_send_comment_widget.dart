import 'package:flutter/material.dart';

class DialogSendCommentWidget extends StatefulWidget {
  final Function() onPress;
  final Function(String text) onChangeMail;
  final Function(String text) onChangeName;
  final Function(String text) onChangeBody;

  const DialogSendCommentWidget(
      {Key? key,
      required this.onPress,
      required this.onChangeMail,
      required this.onChangeName,
      required this.onChangeBody})
      : super(key: key);

  @override
  _DialogSendCommentWidgetState createState() =>
      _DialogSendCommentWidgetState();
}

class _DialogSendCommentWidgetState extends State<DialogSendCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          ElevatedButton(
              onPressed: widget.onPress,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 24, right: 25),
                child: Text(
                  'Отправить',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
              )),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: widget.onChangeMail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  onChanged: widget.onChangeName,
                  decoration: const InputDecoration(
                    labelText: 'Имя',
                    border: OutlineInputBorder(),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  onChanged: widget.onChangeBody,
                  decoration: const InputDecoration(
                    labelText: 'Коментарий',
                    border: OutlineInputBorder(),
                  )),
            ),
          ],
        ));
  }
}
