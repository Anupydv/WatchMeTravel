import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_me_travel/pages/Loginpage.dart';
import 'package:watch_me_travel/resources/auth_methods.dart';
import 'package:watch_me_travel/responsive/responsive_layout.dart';
import 'package:watch_me_travel/utils/colors.dart';
import 'package:watch_me_travel/utils/util.dart';
import 'package:watch_me_travel/widgets/text_field.dart';
import 'dart:io';

import '../responsive/mobile_layout.dart';
import '../responsive/web_layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void SignupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignupUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnakbars(res, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Responsive(
                  mobileLayout: MobileLayout(),
                  webLayout: WebLayout(),
                )),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPage()),
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
            //SvgPicture.asset(
            //'assets/signupimg.svg',
            //height: 88,
            //),

            const SizedBox(
              height: 44,
            ),

            //circular widget to accept and show our selected file

            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://pbs.twimg.com/profile_images/1475161591112888321/s7vffAV8_400x400.jpg'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 44,
            ),

            //username textfield

            InputTextField(
              hintText: 'Enter your Username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),

            const SizedBox(
              height: 24,
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

            //Bio textfield
            InputTextField(
              hintText: 'Enter your Bio',
              textInputType: TextInputType.text,
              textEditingController: _bioController,
            ),

            const SizedBox(
              height: 24,
            ),

            //button
            InkWell(
              onTap: SignupUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign In"),
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
                  child: const Text("Do you have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: const Text(
                      "Log In",
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
