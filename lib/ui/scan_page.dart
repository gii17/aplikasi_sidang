import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:http/http.dart' as http;

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _excreptController = TextEditingController();
  TextEditingController _profileController = TextEditingController();
  TextEditingController _layananController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  Future saveProduct() async {
    final response = await http
        .post(Uri.parse("http://192.168.43.170:8080/api/tekno"), body: {
      "nama": _namaController.text,
      "category": _categoryController.text,
      "excrept": _excreptController.text,
      "profile": _profileController.text,
      "layanan": _layananController.text,
      "image": _imageController.text
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('favorite');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namaController,
                            decoration:
                                InputDecoration(labelText: "name member"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan nama Product";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _categoryController,
                            decoration: InputDecoration(labelText: "category"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan category id";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _excreptController,
                            decoration: InputDecoration(labelText: "excrept"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan excrept";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _profileController,
                            decoration: InputDecoration(labelText: "profile"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan profile Product";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _layananController,
                            decoration: InputDecoration(labelText: "layanan"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan layanan Product";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _imageController,
                            decoration: InputDecoration(labelText: "IMG URL"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan image Product";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                            child: MaterialButton(
                                minWidth: 320,
                                height: 60,
                                onPressed: () {
                                  final form = _formKey.currentState;
                                  if (form != null && form.validate()) {
                                    saveProduct().then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RootPage()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Created successfully"),
                                      ));
                                    });
                                  }
                                },
                                child: Text("submit")),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blueAccent,
//           centerTitle: true,
//           elevation: 0,
//           title: Text('Login'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 decoration: const InputDecoration(hintText: 'Enter username'),
//                 onChanged: (value) {
//                   _username = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 obscureText: true,
//                 decoration: const InputDecoration(hintText: 'Enter password'),
//                 onChanged: (value) {
//                   _password = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               RoundedButton(
//                 btnText: 'Login',
//                 onBtnPressed: () => loginPressed(),
//               )
//             ],
//           ),
//         ));
