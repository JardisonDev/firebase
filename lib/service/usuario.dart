class Usuario {
  String? _email; // O '?' diz que pode ser nulo
  String? _senha;

  Usuario();

  String? get email => _email;
  set email(String? value) => _email = value;

  String? get senha => _senha;
  set senha(String? value) => _senha = value;
}
