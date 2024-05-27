import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';

class AppAlertDialog {
  static Widget buildDialog(BuildContext context, String title, String message) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.dismissString),
        ),
      ],
    );
  }
}
