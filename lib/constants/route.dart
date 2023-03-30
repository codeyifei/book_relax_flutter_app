import 'package:book_relax_flutter_app/screen/home.dart';
import 'package:book_relax_flutter_app/screen/login.dart';
import 'package:book_relax_flutter_app/screen/reader.dart';
import 'package:flutter/material.dart';

typedef ScreenBuilder = Widget Function(BuildContext context);

class AppRoute {
  static Map<String, ScreenBuilder> routes() {
    Map<String, ScreenBuilder> routes = {};
    var appPaths = AppPath.values;
    for (var value in appPaths) {
      routes[value.path] = value.builder;
    }
    return routes;
  }
}

enum AppPath {
  home('/', HomeScreen()),
  login('/login', LoginScreen()),
  reader('/reader', ReaderScreen());

  final String path;
  final Widget widget;

  const AppPath(this.path, this.widget);

  Widget Function(BuildContext context) get builder => (context) => widget;
}
