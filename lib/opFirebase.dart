import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OpFirebase extends StatefulWidget {
  OpFirebase({Key key}) : super(key: key);

  @override
  _OpFirebaseState createState() => _OpFirebaseState();
}

class _OpFirebaseState extends State<OpFirebase> {
  final firebaseInstance = FirebaseFirestore.instance;

  void _agregarFirebase() {
    firebaseInstance.collection('personas').add(
        {'nombre': 'Carlos', 'edad': '20', 'pais': 'México', 'activo': true});
  }

  void _agregarIdFirebase() {
    firebaseInstance.collection('personas').doc('id_personalizado').set(
        {'nombre': 'Mario', 'edad': '32', 'pais': 'India', 'activo': false});
  }

  void _actualizarFirebase() {
    firebaseInstance
        .collection('personas')
        .doc('id_personalizado')
        .update({'nombre': 'Juan', 'activo': true});
  }

  void _listarFirebase() {
    firebaseInstance.collection('personas').get().then((resultado) {
      resultado.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  void _listarPersonalizadoFirebase() {
    firebaseInstance
        .collection('personas')
        .doc('id_personalizado')
        .get()
        .then((value) {
      print(value.data());
    });
  }

  void _buscarFirebase() {
    firebaseInstance
        .collection('personas')
        .where('pais', isEqualTo: 'México')
        .snapshots()
        .listen((result) {
      result.docs.forEach((doc) {
        print(doc.data());
      });
    });
  }

  void _borrarFirebase() {
    firebaseInstance.collection('personas').doc('id_personalizado').delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operaciones Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _agregarFirebase();
              },
              child: Text('Agregar', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _agregarIdFirebase();
              },
              child: Text('ID Personalizado', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _actualizarFirebase();
              },
              child: Text('Actualizar', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _listarFirebase();
              },
              child: Text('Listar', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _listarPersonalizadoFirebase();
              },
              child: Text('Listar Personalizado',
                  style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _buscarFirebase();
              },
              child: Text('Buscar', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                _borrarFirebase();
              },
              child: Text('Borrar', style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
}
