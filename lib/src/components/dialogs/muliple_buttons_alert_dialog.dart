import 'package:flutter/material.dart';

class MulipleButtonsAlertDialog {
  static Widget buildDialog(BuildContext context, String title, String message, List<Widget> textButtons) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        ...textButtons,
      ],
    );
  }
}
