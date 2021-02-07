import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

// import 'package:speech_to_text/speech_to_text_web.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void switchScreen(str, context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UploadPage(url: str)));
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
              "Insert the URL that will receive the Multipart POST request (including the starting http://)",
              style: Theme.of(context).textTheme.headline),
          TextField(
            controller: controller,
            onSubmitted: (str) => switchScreen(str, context),
          ),
          FlatButton(
            child: Text("Take me to the upload screen"),
            onPressed: () => switchScreen(controller.text, context),
          )
        ],
      ),
    ));
  }
}

class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _UploadPageState createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadPage> {

  Future<String> uploadAudio(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('audio', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }
  String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(state)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult result =await FilePicker.platform.pickFiles(type: FileType.audio);
          if (result != null) {
            var res = await uploadAudio(result.files.first.path, widget.url);
          setState(() {
            state = res;
            print(res);
          });
            }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
