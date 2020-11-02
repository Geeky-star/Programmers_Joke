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
    response = await http.get('api');
//https://www.googleapis.com/books/v1/volumes?q=isbn:0747532699
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        ljokes = mapResponse['items'];
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
                        Text(
                          "Book Title",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(ljokes[index]['volumeInfo']['title'].toString(),
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(ljokes[index]['volumeInfo']['authors'].toString(),
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Publisher",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ljokes[index]['volumeInfo']['publisher'].toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Published Date",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ljokes[index]['volumeInfo']['publishedDate']
                              .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ljokes[index]['volumeInfo']['description'].toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Book Link",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ljokes[index]['selfLink'].toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                }));
  }
}
