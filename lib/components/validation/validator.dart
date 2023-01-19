class Validator {
  static const String _emailRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String _mobileNoRegExp = r'^(?:[+0][0-9])?[0-9]{11}$';

  static String? nameValidator(String? name) {
    if (name!.trim().isEmpty) return 'Name is Required.';
    if (name.length < 2) return 'Name must be at least 2 characters.';
    if (name.length > 50) return 'Name must be at most 50 character.';
    return null;
  }

  static String? emailValidator(String? email) {
    if (email!.trim().isEmpty) return 'Email is Required.';
    if (!RegExp(_emailRegExp).hasMatch(email)) return 'Invalid format.';
    return null;
  }

  static String? mobileNoValidator(String? mobileNo) {
    if (mobileNo!.trim().isEmpty) return 'Mobile No is Required.';
    if (!RegExp(_mobileNoRegExp).hasMatch(mobileNo)) return 'Invalid mobile no format.';
    // if (mobileNo.length != 11) return 'Mobile No must have 11 digits.';
    return null;
  }

  static String? addressValidator(String? address) {
    if (address!.trim().isEmpty) return 'Address is Required.';
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.trim().isEmpty) return 'Password is Required.';
    if (password.length < 6) return 'Password must be at least 6 characters.';
    if (password.length > 100) return 'Password must be at most 1000 character.';
    return null;
  }

  static String? confirmPasswordValidator(String? confirmPassword, String? password) {
    if (confirmPassword != password) return 'Password is\'t identical.';
    return null;
  }

  static String? passwordLoginValidator(String? password) {
    if (password!.trim().isEmpty) return 'Password is Required.';
    return null;
  }
}
