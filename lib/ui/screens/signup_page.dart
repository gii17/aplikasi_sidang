import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/custom_textfield.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:flutter_onboarding/ui/screens/rounded_button.dart';
import 'package:flutter_onboarding/ui/services/auth_services.dart';
import 'package:flutter_onboarding/ui/services/globals.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/custom_textfield.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _username = '';
  String _password = '';

  createAccountPressed() async {
    bool usernameValid = RegExp("").hasMatch(_username);
    if (usernameValid) {
      http.Response response =
          await AuthServices.register(_username, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SignIn()));
      } else {
        errorSnackbar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackbar(context, 'username not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/signup.png'),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter username',
                      icon: Icon(
                        Icons.assignment_ind_outlined,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _username = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                      icon: Icon(
                        Icons.lock,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RoundedButton(
                      btnText: 'Register',
                      onBtnPressed: () => createAccountPressed(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignIn()));
                      },
                      child: const Text("sudah mendaftar?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                ],
              ),
            )));
  }
}



// class SignUp extends StatelessWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset('assets/images/signup.png'),
//               const Text(
//                 'Sign Up',
//                 style: TextStyle(
//                   fontSize: 35.0,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               const CustomTextfield(
//                 obscureText: false,
//                 hintText: 'Enter Email',
//                 icon: Icons.alternate_email,
//               ),
//               const CustomTextfield(
//                 obscureText: false,
//                 hintText: 'Enter Full name',
//                 icon: Icons.person,
//               ),
//               const CustomTextfield(
//                 obscureText: true,
//                 hintText: 'Enter Password',
//                 icon: Icons.lock,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: Constants.primaryColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                   child: const Center(
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: const [
//                   Expanded(child: Divider()),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('OR'),
//                   ),
//                   Expanded(child: Divider()),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: size.width,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Constants.primaryColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       height: 30,
//                       child: Image.asset('assets/images/google.png'),
//                     ),
//                     Text(
//                       'Sign Up with Google',
//                       style: TextStyle(
//                         color: Constants.blackColor,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       PageTransition(
//                           child: const SignIn(),
//                           type: PageTransitionType.bottomToTop));
//                 },
//                 child: Center(
//                   child: Text.rich(
//                     TextSpan(children: [
//                       TextSpan(
//                         text: 'Have an Account? ',
//                         style: TextStyle(
//                           color: Constants.blackColor,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Login',
//                         style: TextStyle(
//                           color: Constants.primaryColor,
//                         ),
//                       ),
//                     ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
