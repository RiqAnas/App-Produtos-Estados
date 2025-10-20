class Authexception implements Exception {
  final String key;

  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'algo deu errado, tente novamente mais tarde',
    'EMAIL_NOT_FOUND': 'Email não encontrado',
    'INVALID_PASSWORD': 'Senha incorreta',
    'USER_DISABLED': 'Usuário desabilitado',
  };

  Authexception(this.key);

  @override
  String toString() {
    // TODO: implement toString
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
