import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Httpcommunication(),
    );
  }
}

class Httpcommunication extends StatefulWidget {
  const Httpcommunication({super.key});

  @override
  State<Httpcommunication> createState() => _HttpcommunicationState();
}

class _HttpcommunicationState extends State<Httpcommunication> {
  final model  = HttpcommunicationModel();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP 통신'),
      ),
      body: Center(
          child: ListenableBuilder(listenable: model, builder: (BuildContext
          context, Widget? child) {
            return Text('${model.title} : ${model.body}');
          },
          ),
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () {
        model.getUiData();
      }),
    );
  }
}

class HttpcommunicationModel with ChangeNotifier {
  String _title = '';
  String _body = 'Loading';

    Httpcommunication() {
      getUiData();
    }

  String get title => _title;
  String get body => _body;
  Future<String> _getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  void getUiData() async {
    final jsonString = await _getData();
    final jsonMap = jsonDecode(jsonString) as Map;

    _body = jsonMap['body'];
    _title = jsonMap['title'];

    notifyListeners();
  }


}


