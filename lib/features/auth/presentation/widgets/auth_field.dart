import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscure,
      controller: widget.controller,
      decoration: InputDecoration(hintText: widget.hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.hintText} can't be empty";
        }
        return null;
      },
    );
  }
}
