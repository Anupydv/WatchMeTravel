import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_me_travel/pages/SignUpPage.dart';
import 'package:watch_me_travel/resources/auth_methods.dart';
import 'package:watch_me_travel/utils/colors.dart';
import 'package:watch_me_travel/utils/util.dart';
import 'package:watch_me_travel/widgets/text_field.dart';

import '../responsive/mobile_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Responsive(
                  mobileLayout: MobileLayout(),
                  webLayout: WebLayout(),
                )),
      );
    } else {
      showSnakbars(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //image
            SvgPicture.asset(
              'assets/login.svg',
              height: 190,
            ),

            const SizedBox(
              height: 44,
            ),
            //email textfield
            InputTextField(
              hintText: 'Enter your Email Address',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),

            //password textfield
            InputTextField(
              hintText: 'Enter your Password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),

            const SizedBox(
              height: 24,
            ),

            //button
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : const Text("LogIn"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      //body: Text("Login Page"),
    );
  }
}
