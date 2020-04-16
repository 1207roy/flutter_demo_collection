
class Validators {
  static final RegExp _emailRegEx = RegExp(
    r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',
  );

  static final RegExp _passwordRegEx = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegEx.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegEx.hasMatch(password);
  }
}
