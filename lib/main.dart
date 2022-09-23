import 'package:flutter/material.dart';
import 'package:login_screen/screens/intro_page.dart';
import 'package:login_screen/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isLoggedIn = prefs.getBool('isloggedIn') ?? false;
  bool? isIntroValue = prefs.getBool('isIntroValue') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login_page',
      routes: {
        '/': (context) => const HomePage(),
        'login_page': (context) => const LoginPage(),
        'intro_screen': (context) => const IntroScreen(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("shared_preferences"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
