import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final firebaseInstance = FirebaseFirestore.instance;

  FocusNode nombreFocus, correoFocus, usuarioFocus, passwordFocus;
  String nombre, correo, usuario, password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login con Firestore'),
          backgroundColor: Colors.cyan.shade800,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Registro',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      labelText: 'Nombre',
                    ),
                    onSaved: (value) {
                      nombre = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: nombreFocus,
                    onEditingComplete: () {
                      requestFocus(context, correoFocus);
                    },
                    textInputAction: TextInputAction.next,
                    //controller: nombreTextController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Correo',
                        hintText: 'example@gmail.com'),
                    onSaved: (value) {
                      correo = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: correoFocus,
                    onEditingComplete: () =>
                        requestFocus(context, usuarioFocus),
                    textInputAction: TextInputAction.next,
                    //controller: apellidoTextController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      labelText: 'Usuario',
                    ),
                    onSaved: (value) {
                      usuario = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: usuarioFocus,
                    onEditingComplete: () {
                      requestFocus(context, passwordFocus);
                    },
                    textInputAction: TextInputAction.next,
                    //controller: nombreTextController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelText: 'Password'),
                    onSaved: (value) {
                      password = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: passwordFocus,
                    onEditingComplete: () {
                      _registrarFirebase();
                    },
                    //controller: apellidoTextController,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: 360.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.cyanAccent.shade700,
                      textColor: Colors.white,
                      onPressed: () {
                        _registrarFirebase();
                      },
                      child: Text('Registrarme',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _registrarFirebase() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      firebaseInstance.collection('Usuarios').add({
        'nombre': nombre,
        'correo': correo,
        'usuario': usuario,
        'password': password
      });

      showDialog(
          context: context,
          builder: (buildercontext) {
            return Center(
              child: AlertDialog(
                title: Text('Registro'),
                content: Text('El registro fue completado exitosamente'),
                actions: [
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Cerrar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    nombreFocus = FocusNode();
    correoFocus = FocusNode();
    usuarioFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    nombreFocus.dispose();
    correoFocus.dispose();
    usuarioFocus.dispose();
    passwordFocus.dispose();
  }
}

class Argumentos {
  String nombre, correo, usuario, password;

  Argumentos({this.nombre, this.correo, this.usuario, this.password});
}
