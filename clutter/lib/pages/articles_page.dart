import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  List<String> _articles;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((currUser) {
      _db.collection('users').document(currUser.uid).get().then((onValue) {
        setState(() {
          _articles = onValue.data['articles'].toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CS411 Demo'),
        ),
        body: _articles == null
            ? new Container()
            : new Center(
                child: new ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Text(_articles[index]);
                    })));
  }
}
