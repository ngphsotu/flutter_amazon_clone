import '/utils/utils.dart';
import '/utils/constants.dart';
import '/utils/color_themes.dart';
import 'package:flutter/material.dart';
import '/widget/text_field_widget.dart';
import '/widget/custom_main_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.5,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign-In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 33),
                        ),
                        TextFieldWidget(
                          title: 'Email',
                          controller: emailController,
                          obscureText: false,
                          hintText: 'Enter your email',
                        ),
                        TextFieldWidget(
                          title: 'Password',
                          controller: passwordController,
                          obscureText: false,
                          hintText: 'Enter your password',
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                            onPressed: () {},
                            isLoading: false,
                            color: yellowColor,
                            child: const Text(
                              'Sign-In',
                              style: TextStyle(
                                letterSpacing: 0.6,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'New to Amazon?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {},
                    child: const Text(
                      'Create an Amazon Account',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.6,
                        //fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
