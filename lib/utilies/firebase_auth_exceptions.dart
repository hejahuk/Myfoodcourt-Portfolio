class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password provided is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      default:
        return 'An unexpected Firebase authentication error occurred. Please try again.';
    }
  }
}

class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }
}

class TFormatException implements Exception {
  final String message;

  const TFormatException([
    this.message =
        'An unexpected format error occurred. Please check your input.',
  ]);

  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
          'The email address format is invalid. Please enter a valid email.',
        );
      case 'invalid-phone-number-format':
        return const TFormatException(
          'The provided phone number format is invalid.',
        );
      default:
        return const TFormatException();
    }
  }
}

class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network_error':
        return 'A network error occurred. Please check your internet connection.';
      default:
        return 'A platform error occurred. Please try again.';
    }
  }
}
