import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_2021/models/user.dart';
import 'package:solution_challenge_2021/repositories/user_dao.dart';
import 'package:solution_challenge_2021/views/Screens/Login/login_screen.dart';
import 'package:solution_challenge_2021/views/components/already_have_an_account_acheck.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/components/rounded_input_field.dart';
import 'package:solution_challenge_2021/views/components/rounded_password_field.dart';

class Body extends StatelessWidget {
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
              "assets/icons/sign-up.svg",
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
                _password = Crypt.sha256(value).toString();
                print(_password);
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () async {
                User user = new User(
                    username: _username, password: _password.toString());
                await UserDAO.userDAO.addUser(user);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
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
