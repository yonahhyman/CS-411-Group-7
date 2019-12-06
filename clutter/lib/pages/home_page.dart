import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clutter/containers/drawer/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.data}) : super(key: key);
  final String data;
  @override
  _HomePageState createState() => _HomePageState();
}

Future<http.Response> fetchPost(String input) {
  return http.post("http://35.237.20.51:5000/result/", body: {'input': input});
}

class _HomePageState extends State<HomePage> {
  var result;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  DocumentReference _userDoc;
  List<String> _articles;

  @override
  void initState() {
    super.initState();
    fetchPost(widget.data).then((onValue) {
      result = jsonDecode(onValue.body)[0];
      setState(() {
        result = jsonDecode(onValue.body)[0];
      });
      _auth.currentUser().then((currUser) {
        _userDoc = _db.collection('users').document(currUser.uid);
        _userDoc.get().then((onValue) {
          _articles = onValue.data['articles'].toList();
        });
        _articles.add(result);
        _userDoc.updateData(<String, dynamic>{'articles': _articles});
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
        drawer: DrawerContainer(),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(result)]),
        )),
      );
    }
  }
}
