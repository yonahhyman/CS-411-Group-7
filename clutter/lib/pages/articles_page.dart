import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clutter/containers/drawer/drawer.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  List<String> _articles = [];

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((currUser) {
      _db.collection('users').document(currUser.uid).get().then((onValue) {
        for (var article in onValue.data['articles']) {
          _articles.add(article);
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CS411 Demo'),
        ),
        drawer: DrawerContainer(),
        body: _articles.isEmpty
            ? new Container()
            : new Center(
                child: new ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        child: new Container(
                          padding: new EdgeInsets.all(32.0),
                          child: new Column(
                            children: <Widget>[new Text(_articles[index])],
                          ),
                        ),
                      );
                    })));
  }
}
