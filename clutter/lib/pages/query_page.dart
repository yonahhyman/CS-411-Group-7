import 'package:flutter/material.dart';
import 'package:clutter/pages/home_page.dart';
import 'package:clutter/pages/random_page.dart';
import 'package:clutter/containers/drawer/drawer.dart';

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
        title: Text('The Scallion'),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerContainer(),
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
                      builder: (BuildContext context) => HomePage(
                          data: textEditingController.text)));
                }),
                RaisedButton(
                  child: Text("Generate Random Article"),
                  onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RandomPage()));
                },)
          ],
        ),
      )),
    );
  }
}
