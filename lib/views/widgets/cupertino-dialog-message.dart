import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCupertinoDialogBox(BuildContext context,title,message) => showCupertinoDialog<String>(
  context: context,
  builder: (BuildContext context) => CupertinoAlertDialog(
    title:  Text(title),
    content:  Text(message),
    actions: <Widget>[
      TextButton(
        onPressed: () async {
          Navigator.pop(context, 'Ok');
          // setState(() => isAlertSet = false);

        },
        child: const Text('OK'),
      ),
    ],
  ),
);