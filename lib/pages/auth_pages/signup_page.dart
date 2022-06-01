import 'package:customrig/pages/auth_pages/login_page.dart';
import 'package:customrig/pages/main_page.dart';
import 'package:customrig/providers/authentication/auth_provider.dart';
import 'package:customrig/utils/helpers.dart';
import 'package:customrig/utils/validators.dart';
import 'package:customrig/widgets/buttons/primary_button.dart';
import 'package:customrig/widgets/global_widgets/my_circular_progress_indicator.dart';
import 'package:customrig/widgets/text_fields/password_text_field.dart';
import 'package:customrig/widgets/text_fields/primary_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Consumer<AuthProvider>(
      builder: ((context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              height: screenSize.height - padding.top - padding.bottom,
              child: Form(
                key: value.signupFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    _topLoginText(context),
                    spacer(height: 32.0),
                    PrimaryTextField(
                      controller: value.emailController,
                      hintText: 'Email',
                      icon: EvaIcons.emailOutline,
                      validator: (str) => Validator.isValidEmail(str),
                    ),
                    spacer(height: 12.0),
                    PasswordTextField(
                      isForgot: false,
                      controller: value.passwordController,
                      validator: (str) => Validator.isValidPassword(str),
                    ),
                    spacer(height: 12.0),
                    PasswordTextField(
                        isForgot: false,
                        hintText: 'Confirm Password',
                        controller: value.confirmPasswordController,
                        validator: (str) {
                          if (str!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value.passwordController.text == str) {
                            return null;
                          } else {
                            return 'Password do no match';
                          }
                        }),
                    _showErrorMessage(context, value),
                    PrimaryButton(
                      text: 'sign up',
                      onPressed: () async {
                        await value.handleSignUp();
                        if (value.state == AuthState.complete) {
                          pushReplacement(context, const MainPage());
                        }
                      },
                      suffix: value.state == AuthState.loading
                          ? Row(
                              children: [
                                spacer(width: 6),
                                const MyCircularProgressIndicator(),
                              ],
                            )
                          : const Icon(EvaIcons.chevronRight),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            value.disposeProvider();
                            replacePage(context, const LoginPage());
                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _showErrorMessage(BuildContext context, AuthProvider error) {
    if (error.errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Text(
          error.errorMessage,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }
    return spacer(height: 24);
  }

  Widget _topLoginText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // const Text('Please sign in to continue'),
        ],
      ),
    );
  }
}
