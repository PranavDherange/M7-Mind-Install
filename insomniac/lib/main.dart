// ignore: avoid_web_libraries_in_flutter
// import 'package:universal_html/html.dart';
// import 'dart:html';
// import 'dart:io';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
// import 'package:audio_recorder/audio_recorder.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:async/async.dart';

// import 'package:speech_to_text/speech_to_text_web.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

const String _url = "https://sw-detect.herokuapp.com/voiceToText";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> uploadAudio(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('audioPath', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  String resu = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(resu)],
        ),
      ),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () async {
              FilePickerResult result =
                  await FilePicker.platform.pickFiles(type: FileType.audio);
              if (result != null) {
                // File file = File.fromRawPath(result.files.single.bytes);
                // File file = File(result.files.single.path);
                var res = await uploadAudio(result.files.single.path, _url);
                setState(() {
                  resu = res;
                  print(res);
                });
              }
            }),
        IconButton(
          icon: Icon(Icons.mic),
          onPressed: () {},
        )
      ]),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   void switchScreen(str, context) => Navigator.push(
//       context, MaterialPageRoute(builder: (context) => UploadPage(url: str)));
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: <Widget>[
//           FlatButton(
//             child: Text("Upload"),
//             onPressed: () => switchScreen(_url, context),
//           )
//         ],
//       ),
//     ));
//   }
// }

// class UploadPage extends StatefulWidget {
//   UploadPage({Key key, this.url}) : super(key: key);

//   final String url;

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   Future<String> uploadAudio(filename, url) async {
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath('audioPath', filename));
//     var res = await request.send();
//     return res.reasonPhrase;
//   }

//   String state = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter File Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[Text(state)],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           FilePickerResult result =
//               await FilePicker.platform.pickFiles(type: FileType.audio);
//           if (result != null) {
//             // File file = File.fromRawPath(result.files.single.bytes);
//             // File file = File(result.files.single.path);
//             var res = await uploadAudio(result.files.single.path, _url);
//             setState(() {
//               state = res;
//               print(res);
//             });
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// Future<String> upload(File audioFile) async {
//   var stream =
//       new http.ByteStream(DelegatingStream.typed(audioFile.openRead()));
//   int length = await audioFile.length();
//   var uri = Uri.parse(_url);
//   var request = new http.MultipartRequest("POST", uri);
//   var multipartFile = new http.MultipartFile('file', stream, length,
//       filename: basename(audioFile.path));
//   request.files.add(multipartFile);
//   var response = await request.send();

//   return response.reasonPhrase;
// }
