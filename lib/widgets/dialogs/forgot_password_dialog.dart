import 'package:customrig/utils/validators.dart';
import 'package:customrig/widgets/text_fields/primary_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final GlobalKey formKey;
  final Widget button;
  final String message;

  const ForgotPasswordDialog({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.formKey,
    required this.button,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Form(
        key: formKey,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Forgot your password?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryTextField(
                hintText: 'email',
                controller: controller,
                validator: (str) => Validator.isValidEmail(str),
              ),
              if (message.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 14),
                  ),
                )
            ],
          ),
          actions: [
            TextButton(onPressed: onSubmit, child: button),
          ],
        ),
      );
    });
  }
}
