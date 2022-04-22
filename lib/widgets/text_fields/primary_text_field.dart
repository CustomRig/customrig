import 'package:customrig/widgets/text_fields/base_text_field.dart';
import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;

  const PrimaryTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: controller,
      hintText: hintText,
      icon: icon,
      validator: validator,
    );
  }
}
