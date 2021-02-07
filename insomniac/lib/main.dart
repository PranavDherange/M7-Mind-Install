import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  _MyHomePageState createState() => _MyHomePageState();
}

const hostURL = "http://127.0.0.1:5000/hi";
// const hostURL = "https://zomniac.herokuapp.com/";

class _MyHomePageState extends State<MyHomePage> {
  // Future<void> _listenbackend() async {
  //   bool _service;
  //   _service = await _getValue();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text("Demo"),
      ),
      body: Container(
        child: _getValue(),
      ),
    );
  }
}

http.Client _client() {
  return http.Client();
}

// void check(){
//   if(_getValue()==true){
//     _addText(str)
//   }
// }

Widget _getValue() {
  var client = _client();
  try {
    client.post(
      hostURL,
      body: {"Query": "bla"},
    )..then((res) {
        Map<String, dynamic> data = jsonDecode(res.body);
        _addText(data['response']);
      });
    // return true;
  } catch (e) {
    print(e);
    // return false;
  } finally {
    client.close();
  }
}

void _addText(String str) {
  Text(str);
}
