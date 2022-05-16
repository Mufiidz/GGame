import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ggame/screen/home/home_screen.dart';
import 'package:ggame/screen/interest/interest_screen.dart';
import 'package:ggame/res/string_src.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences _sharedPreferences;
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    appName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "0.0.1",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
            Flexible(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Text(
                "From",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.network(
                logo,
                width: size.height * 0.1,
                height: size.height * 0.1,
              ),
            ]))
          ]),
        ),
      ),
    );
  }

  void _initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var name = _sharedPreferences.getString(SharedPrefs.name) ?? '';
    Timer(const Duration(seconds: 3), () {
      AppRoute.clearTopTo(
          name.isEmpty ? const InterestScreen() : const HomeScreen());
    });
  }
}
