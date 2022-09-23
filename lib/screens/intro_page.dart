import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Timer(const Duration(seconds: 3), () async {
      await prefs.setBool('isIntroValue', true);

      Navigator.of(context).pushReplacementNamed('login_page');
    });
  }

  @override
  void initState() {
    super.initState();
    checkPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Intro Screen"),
      ),
      body: Column(
        children: const [
          FlutterLogo(size: 200),
          CircularProgressIndicator(),
          Text("welcome..."),
        ],
      ),
    );
  }
}
