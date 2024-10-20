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
  String body = 'Loading';
  Future<String> getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url);
     print(response.body);
     return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP 통신'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              body = snapshot.data!;
            }
            return Text(body);
          }
        ),
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () {
        getData();
      }),
    );
  }
}


