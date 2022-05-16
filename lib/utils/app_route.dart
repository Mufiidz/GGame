import 'package:flutter/cupertino.dart';

class AppRoute {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  static Future to(
    Widget route,
  ) {
    return navigator.push(CupertinoPageRoute(builder: (context) => route));
  }

  static Future clearTopTo(
    Widget route,
  ) {
    return navigator
        .pushReplacement(CupertinoPageRoute(builder: (context) => route));
  }

  static Future clearAll(
    Widget route,
  ) {
    return navigator.pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => route), (route) => false);
  }

  static void back<T extends Object?>([
    T? result,
  ]) {
    return navigator.pop(result);
  }
}
