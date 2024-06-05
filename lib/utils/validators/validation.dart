
class TValidator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required.';
    }

    // regular expression for email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for length less than 6
    if(value.length < 6){
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least one special character.';
    }

    return null;
    // check requirement for password here
  }

  static String? validatePhone(String? value) {
    return null;
  
    // check requirement for password here
  }


}