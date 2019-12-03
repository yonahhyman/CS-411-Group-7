import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.data}) : super(key: key);
  final String data;
  @override
  _HomePageState createState() => _HomePageState();
}

Future<http.Response> fetchPost(String input) {
  return http.post("http://35.229.109.77:5000/result/", body: {'input': input});
}

class _HomePageState extends State<HomePage> {
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
          title: Text('Clutter'),
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
