import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LogIn {}

class LogInSuccessful {
  final DocumentSnapshot user;

  LogInSuccessful({@required this.user});

  @override
  String toString() {
    return 'LogIn{user: $user}';
  }
}

class LogInFail {
  final dynamic error;
  LogInFail(this.error);

  @override
  String toString() {
    return 'LogIn{There was an error logging in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();
  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}

class LogOutFail {
  final dynamic error;
  LogOutFail(this.error);
  String toString() {
    return '{There was an error logging out: $error}';
  }
}
