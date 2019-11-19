import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDB {
  String uid;
  String uname;
  String number;

  UpdateDB(
      {@required this.uid,
      @required this.uname,
      @required this.number});
}

class RunUpdateReducer {
  final DocumentSnapshot user;

  RunUpdateReducer({@required this.user});
}
