import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(HttpcommunicationModel());

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   Httpcommunication(),
      );

  }
}

class Httpcommunication extends StatelessWidget {
  const Httpcommunication({
    super.key,
   });

  @override
  Widget build(BuildContext context) {
    final HttpcommunicationModel model = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP 통신'),
      ),
      body: Center(
      child: Obx(() => Text('${model.state.value.title} : ${model.state.value.body}'),
      )),

      floatingActionButton: FloatingActionButton(onPressed: () {

        model.getUiData();
      }),
    );
  }
}

class HttpcommunicationModel extends GetxController {
  Rx<HttpState> state = HttpState().obs;

  HttpcommunicationModel() {
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

      state.value = state.value.copyWith(
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

