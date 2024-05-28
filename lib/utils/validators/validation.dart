
class TValidator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required.';
    }

    // regular expression for email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-\+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    // check requirement for password here
  }

  static String? validatePhone(String? value) {
    // check requirement for password here
  }


}