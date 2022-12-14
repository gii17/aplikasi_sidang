import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/signup_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_onboarding/ui/root_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  Future getLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('nama_user'));
    if (pref.getString('nama_user') != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => RootPage()))
          .then((value) {
        setState(() {});
      });
    }
  }

  Future login() async {
    var url = Uri.parse('http://192.168.43.13:8080/loginflutter/login.php');
    final response = await http
        .post(url, body: {'username': user.text, 'password': pass.text});

    var jsonObject = json.decode(response.body);

    if (jsonObject.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Username atau Password salah")));
    } else {
      saveData(jsonObject[0]['id_user'], jsonObject[0]['nama_user']);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => RootPage()))
          .then((value) {
        setState(() {});
      });
    }
  }

  void saveData(id, nama) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id_user', id);
    pref.setString('nama_user', nama);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(197, 223, 248, 1),
      body: Center(
          child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        margin: EdgeInsets.all(30),
        child: Container(
          width: MediaQuery.of(context).size.width * 1.5,
          height: MediaQuery.of(context).size.width * 1.5,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logo-karyain.png'),
                width: 150,
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: user,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(4, 163, 236, 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(197, 223, 248, 1))),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(4, 163, 236, 1))),
              ),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.key,
                      color: Color.fromRGBO(4, 163, 236, 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(197, 223, 248, 1))),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(4, 163, 236, 1))),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      )),
                  Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: SignUp(),
                              type: PageTransitionType.bottomToTop));
                    }, //to login screen. We will update later
                    child: const Text(
                      'Register?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
