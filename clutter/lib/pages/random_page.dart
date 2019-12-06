import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomPage extends StatefulWidget {
  RandomPage({Key key}) : super(key: key);
  @override
  _RandomPageState createState() => _RandomPageState();
}

Future<http.Response> fetchPost() {
  return http.get("http://35.237.20.51:5000/result/");
}

class _RandomPageState extends State<RandomPage> {
  var result;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  DocumentReference _userDoc;
  List<String> _articles;

  @override
  void initState() {
    super.initState();
    fetchPost().then((onValue) {
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
          title: Text('CS411 Demo'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result),
            ],
          ),
        )),
      );
    }
  }
}
