import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.data}) : super(key: key);
  final String data;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<http.Response> fetchPost(String input) {
  return http.post("http://35.229.109.77:5000/result/", body: {'input': input});
}

class _MyHomePageState extends State<MyHomePage> {
  var result;

  @override
  void initState() {
    super.initState();
    fetchPost(widget.data).then((onValue) {
      setState(() {
        result = onValue.body;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return new Scaffold(
        body: new Container(
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('CS411 Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result),
            ],
          ),
        ),
      );
    }
  }
}
