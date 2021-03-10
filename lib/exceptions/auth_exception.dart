class AuthException implements Exception {
  static final Map<String, dynamic> errors = {
    "EMAIL_NOT_FOUND": "Email, nao existe",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tente mais tarde",
    "INVALID_PASSWORD": "Senha invalida",
    "USER_DISABLED": "Usuario desativado",
  };
  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return  errors[key];
    } else {
      return 'Aconteceu erro na autenticacao';
    }
  }
}
