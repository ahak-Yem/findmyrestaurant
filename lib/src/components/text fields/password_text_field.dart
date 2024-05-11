import 'package:findmyrestaurant/src/components/app%20buttons/show_password_button.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: ShowPasswordButton(
          onPressed: (bool isObscure) {
            setState(() {
              _obscureText = isObscure;
            });
          },
        )
      ),
      obscureText: _obscureText,
    );
  }
}
