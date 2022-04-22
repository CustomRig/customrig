class Validator {
  static String? isValidEmail(String? input) {
    if (RegExp(r'^\S+@\S+$').hasMatch(input!)) {
      return null;
    } else {
      return 'Please enter a valid email';
    }
  }

  static String? isValidPassword(String? input) {
    if (input!.length >= 8) {
      return null;
    } else {
      return 'Password must be at least 8 characters long';
    }
  }
}
