library routes;

import 'package:clutter/pages/articles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:clutter/pages/auth_page.dart';
import 'package:clutter/pages/loading_page.dart';
import 'package:clutter/pages/query_page.dart';
import 'models/app_state.dart';

Map<String, WidgetBuilder> getRoutes(context, store) {
  return {
    '/': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return QueryPage();
          },
        ),
    '/login': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return AuthPage();
          },
        ),
    '/loading': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return LoadingPage();
          },
        ),
    '/articles': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return ArticlesPage();
          },
        ),
  };
}
