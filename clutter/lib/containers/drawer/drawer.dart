import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:clutter/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:clutter/actions/navigation_actions.dart';
import 'package:clutter/actions/auth_actions.dart';
import 'package:clutter/pages/auth_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DrawerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drawerItems = [
      new DrawerItem("Home Page", Icons.home),
      new DrawerItem("Account Info", Icons.account_circle)
    ];
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        var drawerOptions = <Widget>[];
        for (var i = 0; i < drawerItems.length; i++) {
          var d = drawerItems[i];
          drawerOptions.add(new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == vm.selectedDrawerIndex,
            onTap: () => vm.onSelectItem(i, context),
          ));
        }
        return new Drawer(
            child: Column(children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            accountName: new Text(vm.name),
            accountEmail: new Text(vm.email),
            currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(vm.photoURL),
                ) ??
                Icon(
                  Icons.account_circle,
                  size: 50.0,
                  color: Colors.white,
                ),
          ),
          new Column(children: drawerOptions),
          new Divider(),
          new ListTile(
              leading: Icon(Icons.power_settings_new),
              title: new Text("Logout"),
              onTap: () {
                vm.onLogout(context);
              }),
        ]));
      },
    );
  }
}

class _ViewModel {
  final String name;
  final String email;
  final String photoURL;
  final Function onSelectItem;
  final Function onLogout;
  final int selectedDrawerIndex;

  _ViewModel(
      {this.name,
      this.email,
      this.photoURL,
      this.onSelectItem,
      this.selectedDrawerIndex,
      this.onLogout});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      name: store.state.currentUser.data['displayName'] ?? 'User',
      email: store.state.currentUser.data['email'] ?? 'Logged Out',
      photoURL: store.state.currentUser.data['photoURL'] ?? null,
      selectedDrawerIndex: store.state.navigationState ?? 0,
      onSelectItem: (int selection, context) {
        if (selection == store.state.navigationState) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          store.dispatch(SetCurrentPage(page: selection));
          switch (selection) {
            case 0:
              Navigator.pushReplacementNamed(context, "/");
              return;

            case 1:
              Navigator.pushReplacementNamed(context, "/update");
              return;
          }
        }
      },
      onLogout: (context) {
        store.dispatch(new LogOut());
        var route = new MaterialPageRoute(
            settings: new RouteSettings(name: '/login'),
            builder: (context) => new AuthPage());
        Navigator.of(context)
            .pushAndRemoveUntil(route, ModalRoute.withName('/'));
      },
    );
  }
}
