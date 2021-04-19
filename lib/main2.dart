import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/models/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Luna Cruz',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page Luna Cruz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> _listaUsers;

  Future<List<User>> get users => null;
  Future<List<User>> _obtenerUsuario() async {
    CollectionReference crUsuario =
        FirebaseFirestore.instance.collection("usuario");

    QuerySnapshot usuarios = await crUsuario.get();
    List<User> users = [];

    if (usuarios.docs.length != 0) {
      for (var doc in usuarios.docs) {
        users.add(User());
        print(doc.data());
      }
    }
    return users;
  }

  @override
  void initState() {
    super.initState();

    _listaUsers = _obtenerUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: _listaUsers,
            initialData: List<User>.empty(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: _listadoUsers(snapshot.data),
                );
              } else if (snapshot.error) {
                print(snapshot.error);
                print('Error al conectar a la API');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  // ignore: missing_return
  List<Widget> _listadoUsers(List<User> data) {
    List<Widget> userList = [];

    for (var user in data) {
      userList.add(Card(
        child: Column(
          children: [
            Text(
              'Nombre: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'marker',
                  fontSize: 18),
            ),
            Text(
              'profesion: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'marker2',
                  fontSize: 18),
            )
          ],
        ),
      ));
    }

    return userList;
  }
}
