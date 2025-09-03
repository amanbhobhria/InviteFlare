mixin Validator {
  static String getEmailValidationMessage(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isEmpty) {
      return 'Email address cannot be empty.';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return '';
  }

  static String? passwordValidate(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one digit.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }
    return null; // Valid password
  }

  static String getNameValidationMessage(String name) {
    final nameRegExp = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]{2,50}$');

    if (name.isEmpty) {
      return 'Name cannot be empty.';
    } else if (!nameRegExp.hasMatch(name)) {
      if (name.length < 2) {
        return 'Name must be at least 2 characters long.';
      } else if (name.length > 50) {
        return 'Name cannot exceed 50 characters.';
      } else {
        return 'Name can only contain letters and spaces.';
      }
    }
    return '';
  }

  static String getOtherValidationMessage(String name, String label) {
    final nameRegExp = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]{2,50}$');

    if (name.isEmpty) {
      return '$label cannot be empty.';
    } else if (!nameRegExp.hasMatch(name)) {
      if (name.length < 2) {
        return '$label must be at least 2 characters long.';
      } else if (name.length > 50) {
        return '$label cannot exceed 50 characters.';
      }
    }
    return '';
  }

  static String getIntegerValidationMessage(String name, String label) {
    if (name.isEmpty) {
      return '$label cannot be empty.';
    }

    final intValue = int.tryParse(name);
    if (intValue == null) {
      return 'Enter a valid number';
    } else if (intValue < 1 || intValue > 5) {
      return '$label between 1 and 5';
    }

    return '';
  }
}
