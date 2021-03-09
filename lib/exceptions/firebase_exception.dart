class HttpException implements Exception {
  static final Map<String, dynamic> errors = {
    "EMAIL_NOT_FOUND": "",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "",
    "INVALID_PASSWORD": "",
    "USER_DISABLED": "",
  };
  final String key;

  const HttpException(this.key);

  @override
  String toString() {
    return key;
  }
}
