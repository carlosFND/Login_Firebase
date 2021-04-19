import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login_page.dart';
import 'package:flutter_firebase/pages/principal_page.dart';
import 'package:flutter_firebase/pages/registro_page.dart';

Map<String, WidgetBuilder> obtenerRutas() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'principal': (BuildContext context) => PrincipalPage(),
    'registro': (BuildContext context) => RegistroPage()
  };
}
