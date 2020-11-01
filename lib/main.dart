import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map mapResponse;
  List ljokes;

  Future getJokes() async {
    http.Response response;
    response = await http
        .get('https://sv443.net/jokeapi/v2/joke/Any?type=single&amount=10');

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        ljokes = mapResponse['jokes'];
        debugPrint(ljokes.toString());
        print(ljokes);
        print(mapResponse);
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    getJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Programmers Joke"),
        ),
        body: ljokes == null
            ? Text(
                "wait",
                style: TextStyle(fontSize: 20),
              )
            : ListView.builder(
                itemCount: ljokes == null ? 0 : ljokes.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(ljokes[index]['joke'],
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  );
                }));
  }
}
