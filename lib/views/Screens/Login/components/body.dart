import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_2021/helper/global.dart';
import 'package:solution_challenge_2021/models/user.dart';
import 'package:solution_challenge_2021/repositories/user_dao.dart';
import 'package:solution_challenge_2021/starting.dart';
import 'package:solution_challenge_2021/views/Screens/Login/components/background.dart';
import 'package:solution_challenge_2021/views/Screens/Signup/signup_screen.dart';
import 'package:solution_challenge_2021/views/components/already_have_an_account_acheck.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/components/rounded_input_field.dart';
import 'package:solution_challenge_2021/views/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';


//Future<UserCredential> signInWithGoogle() async {
//  // Trigger the authentication flow
//  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//  // Obtain the auth details from the request
//  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//  // Create a new credential
//  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//    accessToken: googleAuth.accessToken,
//    idToken: googleAuth.idToken,
//  );
//
//  // Once signed in, return the UserCredential
//  return await FirebaseAuth.instance.signInWithCredential(credential);
//}

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);
  
  String _username;
  String _password;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/log-in.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Username",
                    onChanged: (value) {
                      _username = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  RoundedButton(
                    text: "LOG IN",
                    press: () async {
                      User user = await UserDAO.userDAO.getUser(_username);
                      print(user.username);
                      print(user.password);
                      if (user == null) {
                        print("User not found");
                      } else {
                        if (Crypt(user.password).match(_password)) {
                          Global.global.setUsername(_username);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return Main();
                            }),
                          );
                        } else {
                          print("Wrong password");
                        }
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

