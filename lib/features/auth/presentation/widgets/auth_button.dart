import 'package:blog_firebase/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onpressed;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onpressed,
  });

  @override
  State<AuthGradientButton> createState() => _AuthGradientButtonState();
}

class _AuthGradientButtonState extends State<AuthGradientButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onpressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: const Size(395, 55),
        backgroundColor: ColorManager.gradient1,
      ),
      child: Text(
        widget.buttonText,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
