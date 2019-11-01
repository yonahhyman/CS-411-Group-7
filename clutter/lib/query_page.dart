import 'package:flutter/material.dart';
import 'package:clutter/home_page.dart';

class QueryPage extends StatefulWidget {
  QueryPage();
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS411 Demo'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: new Column(
          children: [
            Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      labelText: "Enter a line to start",
                    ),
                    controller: textEditingController)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            RaisedButton(
                child: Text("Get Result"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage(
                          data: textEditingController.text)));
                })
          ],
        ),
      )),
    );
  }
}
