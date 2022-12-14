import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/plants.dart';
import 'package:flutter_onboarding/ui/screens/widgets/plant_widget.dart';
import 'package:flutter_onboarding/ui/screens/edit_member.dart';
import 'package:flutter_onboarding/ui/screens/detail_member.dart';
import 'package:image_network/image_network.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CartPage({Key? key, required this.addedToCartPlants}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final String url = 'http://192.168.43.170:8080/api/teknos';

  Future getMember() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteMember(String memberid) async {
    final String url =
        'http://192.168.43.170:8080/api/tekno-delete/' + memberid;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: getMember(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 180,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              height: 120,
                              width: 120,
                              child: ImageNetwork(
                                image: snapshot.data['data'][index]['image'],
                                height: 120,
                                width: 120,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                              )),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      snapshot.data['data'][index]['nama'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data['data'][index]
                                          ['excrept'])),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          detail_member(
                                                              member: snapshot
                                                                          .data[
                                                                      'data']
                                                                  [index]),
                                                    ));
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.blue,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          edit_member1(
                                                              member: snapshot
                                                                          .data[
                                                                      'data']
                                                                  [index]),
                                                    ));
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                deleteMember(snapshot
                                                        .data['data'][index]
                                                            ['id']
                                                        .toString())
                                                    .then((value) {
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Deleted successfully"),
                                                  ));
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text('data error');
          }
        },
      ),
    );
  }
}

// return Scaffold(
//       body: widget.addedToCartPlants.isEmpty
//           ? Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 100,
//               child: Image.asset('assets/images/add-cart.png'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Your Cart is Empty',
//               style: TextStyle(
//                 color: Constants.primaryColor,
//                 fontWeight: FontWeight.w300,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       )
//           : Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
//         height: size.height,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                   itemCount: widget.addedToCartPlants.length,
//                   scrollDirection: Axis.vertical,
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (BuildContext context, int index) {
//                     return PlantWidget(
//                         index: index, plantList: widget.addedToCartPlants);
//                   }),
//             ),
//             Column(
//               children: [
//                 const Divider(thickness: 1.0,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text('Totals',style: TextStyle(
//                       fontSize: 23,
//                       fontWeight: FontWeight.w300,
//                     ),
//                     ),
//                       Text(r'$65', style: TextStyle(
//                         fontSize: 24.0,
//                         color: Constants.primaryColor,
//                         fontWeight: FontWeight.bold,
//                       ),),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
