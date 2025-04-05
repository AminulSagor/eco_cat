class ValidationUtil {
  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return "Name can't be empty";
    }
    if (name.length < 2) {
      return "Name is too short";
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "Email can't be empty";
    }
    if (!email.contains("@") || !email.contains(".")) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return "Password can't be empty";
    }
    if (password.length < 4) {
      return "Password must be at least 4 characters";
    }
    return null;
  }
}
