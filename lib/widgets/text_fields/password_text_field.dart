import 'package:customrig/widgets/text_fields/base_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final bool isObscure;
  final bool isForgot;
  final VoidCallback? onForgotPasswordClick;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.isObscure = true,
    this.isForgot = true,
    this.validator,
    this.hintText,
    this.onForgotPasswordClick,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isTextEmpty = true;
  late bool obscureText;

  _changeText() {
    setState(() {
      isTextEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  void initState() {
    obscureText = widget.isObscure;
    widget.controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _changeText();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      validator: widget.validator,
      obscureText: obscureText,
      hintText: widget.hintText ?? 'Password',
      controller: widget.controller,
      icon: EvaIcons.lockOutline,
      suffix: widget.controller.text.isNotEmpty
          ? InkWell(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Text(
                obscureText ? 'SHOW' : 'HIDE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : widget.isForgot
              ? InkWell(
                  onTap: widget.onForgotPasswordClick,
                  child: Text(
                    'FORGOT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : null,
    );
  }
}
