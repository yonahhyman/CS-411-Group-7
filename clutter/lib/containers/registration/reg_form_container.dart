import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:clutter/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clutter/actions/reg_actions.dart';
import 'package:clutter/keys/keys.dart';

class RegFormContainer extends StatelessWidget {
  RegFormContainer({Key key}) : super(key: key);
  final navigatorKey = AppKeys.navKey;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return new Container(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: new TextField(
                    controller: vm.usernameController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                new ListTile(
                  title: new TextField(
                    keyboardType: TextInputType.number,
                    controller: vm.phoneController,
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.contact_phone),
                        hintText: "Number",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return RaisedButton(
                        textColor: Colors.white,
                        onPressed: () {
                          vm.update(
                              vm.currentUser.data['uid'],
                              vm.usernameController.text,
                              vm.phoneController.text);
                        },
                        color: Colors.blueAccent,
                        child: Text('Submit'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final DocumentSnapshot currentUser;

  final Function(String, String, String) update;
  final TextEditingController usernameController;
  final TextEditingController phoneController;

  _ViewModel(
      {@required this.currentUser,
      this.usernameController,
      this.phoneController,
      this.update});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        update: (String uid, String uname, String number) {
          store.dispatch(UpdateDB(
              uid: uid,
              uname: uname,
              number: number));
        },
        currentUser: store.state.currentUser,
        usernameController: new TextEditingController.fromValue(new TextEditingValue(
            text: store.state.currentUser.data['uname'] ?? "",
            selection: new TextSelection.collapsed(
                offset: store.state.currentUser.data['uname']?.length ?? 0))),
        phoneController: new TextEditingController.fromValue(new TextEditingValue(
            text: store.state.currentUser.data['number'] ?? "",
            selection: new TextSelection.collapsed(offset: store.state.currentUser.data['number']?.length ?? 0))));
  }
}
