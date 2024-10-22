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
          child: ListenableBuilder(listenable: model,
            builder: (BuildContext
          context, Widget? child) {
            return Text('${model.value.title} : ${model.value.body}');
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

class HttpcommunicationModel extends ValueNotifier<HttpState> {
  HttpcommunicationModel() : super(HttpState()){
    getUiData();
  }




  Future<String> _getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  void getUiData() async {
    final jsonString = await _getData();
    final jsonMap = jsonDecode(jsonString) as Map;

     value = value.copyWith(
      title: jsonMap['title'],
      body: jsonMap['body'],
    );



  }
}

class HttpState {
 final String title;
 final String body;

 HttpState({
   this.title = '',
   this.body = 'Loading',
});
 HttpState copyWith ({
   String? title,
   String? body,
}) {
   return HttpState(
     title: title ?? this.title,
     body: body ?? this.body,
   );
 }
}

