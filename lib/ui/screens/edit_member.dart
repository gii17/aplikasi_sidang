import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:http/http.dart' as http;

class edit_member1 extends StatefulWidget {
  final Map member;

  edit_member1({required this.member});

  @override
  State<edit_member1> createState() => _edit_member1State();
}

class _edit_member1State extends State<edit_member1> {
  final _formKey = GlobalKey<FormState>();

  var _namaController = new TextEditingController();

  var _categoryController = TextEditingController();

  var _excreptController = TextEditingController();

  var _profileController = TextEditingController();

  var _layananController = TextEditingController();

  var _imageController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        Uri.parse("http://192.168.43.170:8080/api/tekno-edit/" +
            widget.member['id'].toString()),
        body: {
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
  void initstate() {
    _namaController.text = widget.member['nama'];
  }

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
                  padding: EdgeInsets.only(top: 40),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namaController
                              ..text = widget.member['nama'],
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
                            controller: _categoryController
                              ..text = widget.member['category'],
                            decoration: InputDecoration(labelText: "Category"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan category";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _excreptController
                              ..text = widget.member['excrept'],
                            decoration: InputDecoration(labelText: "excrept"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan excrept";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _profileController
                              ..text = widget.member['profile'],
                            decoration: InputDecoration(labelText: "profile"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan profile Product";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _layananController
                              ..text = widget.member['layanan'],
                            decoration: InputDecoration(labelText: "layanan"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukan layanan Product";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _imageController
                              ..text = widget.member['image'],
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
                                    updateProduct().then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RootPage()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Update successfully"),
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
