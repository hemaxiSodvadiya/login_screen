import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text("Login Page"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              field(_emailController, const Icon(Icons.email_outlined),
                  "Enter Email"),
              const SizedBox(
                height: 10,
              ),
              field(_passwordController, const Icon(Icons.lock),
                  "Enter password"),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogoutPage()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              const Color(0xff00C8E8) // Your color
                          ),
                      child: Checkbox(
                          activeColor: const Color(0xff00C8E8),
                          value: _isChecked,
                          onChanged: (val) {
                            if (kDebugMode) {
                              print("check Box..........");
                            }
                            _isChecked = val!;

                            SharedPreferences.getInstance().then(
                              (prefs) {
                                prefs.setBool("remember_me", val);
                                prefs.setString("email", _emailController.text);
                                prefs.setString(
                                    "password", _passwordController.text);
                              },
                            );

                            setState(() {
                              _isChecked = val;
                            });
                          }),
                    )),
                const SizedBox(width: 10.0),
                const Text("Remember Me",
                    style: TextStyle(
                      color: Color(0xff646464),
                      fontSize: 12,
                    ))
              ])
            ]),
          ),
        ));
  }

  field(TextEditingController controller, Icon icon, String label) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xffECEBEB))),
      child: TextField(
          controller: controller,
          //onChanged: onchange,

          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8, left: 20),
            border: InputBorder.none,
            suffixIcon: icon,
            labelText: label,
            labelStyle:
                const TextStyle(fontSize: 14, decoration: TextDecoration.none),
          )),
    );
  }

  void _loadUserEmailPassword() async {
    if (kDebugMode) {
      print("Load Email");
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      if (kDebugMode) {
        print(remeberMe);
      }
      if (kDebugMode) {
        print(email);
      }
      if (kDebugMode) {
        print(password);
      }
      if (remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = email ?? "";
        _passwordController.text = password ?? "";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter App"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              child: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
