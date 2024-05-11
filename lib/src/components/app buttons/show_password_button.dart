import 'package:flutter/material.dart';

class ShowPasswordButton extends StatefulWidget {
  final ValueChanged<bool> onPressed;

  const ShowPasswordButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  createState() => _ShowPasswordButtonState();
}

class _ShowPasswordButtonState extends State<ShowPasswordButton> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
        widget.onPressed(_obscureText); // Pass the current visibility state
      },
    );
  }
}
