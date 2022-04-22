import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final Widget? suffix;
  final bool obscureText;
  final String? Function(String?)? validator;

  const BaseTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.suffix,
    this.icon,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        // filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        hintText: hintText,
        label: Text(hintText),
        prefixIcon: icon != null ? Icon(icon) : null,
        prefixIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
        suffix: suffix,
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
