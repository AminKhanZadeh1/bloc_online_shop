class AuthErrors {
  final String message;

  AuthErrors({required this.message});

  factory AuthErrors.fromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return AuthErrors(
            message: 'Email or Password is incorrect. Please try again.');
      case 'network-request-failed':
        return AuthErrors(
            message: 'Network Error. Please check your connection.');
      case 'user-disabled':
        return AuthErrors(
            message:
                'This account has been disabled. Please contact support for assistance.');
      case 'too-many-requests':
        return AuthErrors(
            message: 'Too many requests. Please try again later.');
      case 'email-already-in-use':
        return AuthErrors(message: 'Email already in use. Please Login.');
      case 'weak-password':
        return AuthErrors(message: 'The password is too weak.');
      default:
        return AuthErrors(
            message: 'An unknown error occurred. Please try again.');
    }
  }
}
