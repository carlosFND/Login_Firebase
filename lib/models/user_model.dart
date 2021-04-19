class User {
  String _usuario = '';
  String _password = '';
  String _nombre = '';
  String _correo = '';

  String get getUsuario {
    return _usuario;
  }

  String get getPassword {
    return _password;
  }

  String get getNombre {
    return _nombre;
  }

  String get getCorreo {
    return _correo;
  }

  set usuario(String usuario) {
    this._usuario = usuario;
  }

  set password(String password) {
    this._password = password;
  }

  set nombre(String nombre) {
    this._nombre = nombre;
  }

  set correo(String correo) {
    this._correo = correo;
  }
}
