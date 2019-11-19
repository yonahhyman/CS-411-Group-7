import 'package:flutter/material.dart';
import 'package:clutter/containers/registration/reg_form_container.dart';

class RegisterPage extends StatelessWidget {
  final String title;

  RegisterPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        title: new Text(this.title),
      ),
      body: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: new RegFormContainer(),
        ),
      ),
    );
  }
}
