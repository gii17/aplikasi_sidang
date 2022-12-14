import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/forgot_password.dart';
import 'package:flutter_onboarding/ui/screens/rounded_button.dart';
import 'package:flutter_onboarding/ui/screens/signup_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/custom_textfield.dart';
import 'package:flutter_onboarding/ui/services/auth_services.dart';
import 'package:flutter_onboarding/ui/services/globals.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username = '';
  String _password = '';

  loginPressed() async {
    if (_username.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_username, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const RootPage()));
      } else {
        errorSnackbar(context, responseMap.values.first);
      }
    } else {
      errorSnackbar(context, 'enter all required fields');
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
                  Image.asset('assets/images/signin.png'),
                  Text(
                    'Sign In',
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
                      btnText: 'Login',
                      onBtnPressed: () => loginPressed(),
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
                                    const SignUp()));
                      },
                      child: const Text("Belum Memiliki akun?",
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

// class SignIn extends StatelessWidget {
//   const SignIn({Key? key}) : super(key: key);

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
//               Image.asset('assets/images/signin.png'),
//               const Text(
//                 'Sign In',
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
//                 obscureText: true,
//                 hintText: 'Enter Password',
//                 icon: Icons.lock,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       PageTransition(
//                           child: const RootPage(),
//                           type: PageTransitionType.bottomToTop));
//                 },
                // child: Container(
                //   width: size.width,
                //   decoration: BoxDecoration(
                //     color: Constants.primaryColor,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //   child: const Center(
                //     child: Text(
                //       'Sign In',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 18.0,
                //       ),
                //     ),
                //   ),
                // ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       PageTransition(
//                           child: const ForgotPassword(),
//                           type: PageTransitionType.bottomToTop));
//                 },
//                 child: Center(
//                   child: Text.rich(
//                     TextSpan(children: [
//                       TextSpan(
//                         text: 'Forgot Password? ',
//                         style: TextStyle(
//                           color: Constants.blackColor,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Reset Here',
//                         style: TextStyle(
//                           color: Constants.primaryColor,
//                         ),
//                       ),
//                     ]),
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
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       height: 30,
//                       child: Image.asset('assets/images/google.png'),
//                     ),
//                     Text(
//                       'Sign In with Google',
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
//                           child: const SignUp(),
//                           type: PageTransitionType.bottomToTop));
//                 },
//                 child: Center(
//                   child: Text.rich(
//                     TextSpan(children: [
//                       TextSpan(
//                         text: 'New to Planty? ',
//                         style: TextStyle(
//                           color: Constants.blackColor,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Register',
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


//  return Scaffold(
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