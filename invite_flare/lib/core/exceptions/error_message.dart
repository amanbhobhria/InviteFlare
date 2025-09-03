mixin ErrorMessage {
  static String get code400 =>
      'Invalid request. Please check the input and try again.';

  static String get code401 => """
You're not authorized to access this resource. Please log in and try again.""";

  static String get code403 =>
      "You don't have permission to perform this action.";

  static String get code404 => """
The requested resource couldn't be found. Please check the URL or contact support.""";

  static String get code429 => """
You've made too many requests in a short time. Please wait and try again later.""";

  static String get code500 =>
      'An unexpected error occurred on the server. Please try again later.';

  static String get code502 =>
      'The server received an invalid response. Please try again later.';

  static String get code503 =>
      'The service is temporarily unavailable. Please check back shortly.';

  static String get code504 =>
      'The server took too long to respond. Please try again later.';

  static String get unknownCode => '''
Oops! Something went wrong with your request. Please try again or contact support for help.''';
}
