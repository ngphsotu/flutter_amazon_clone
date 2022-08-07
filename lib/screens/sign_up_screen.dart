// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '/utils/utils.dart';
import 'sign_in_screen.dart';
import '/utils/constants.dart';
import '/utils/color_themes.dart';
import '/widgets/text_field_widget.dart';
import '/widgets/custom_main_button.dart';
import '/resources/authentication_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
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
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        width: screenSize.width * 0.8,
                        height: screenSize.height * 0.85,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text - Sign up
                            const Text(
                              'Sign-Up',
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            // Field
                            TextFieldWidget(
                              title: 'Name',
                              hintText: 'Enter your name',
                              controller: nameController,
                              obscureText: false, // hint text
                            ),

                            // Field
                            TextFieldWidget(
                              title: 'Address',
                              hintText: 'Enter your address',
                              controller: addressController,
                              obscureText: false, // hint text
                            ),

                            // Field
                            TextFieldWidget(
                              title: 'Email',
                              hintText: 'Enter your email',
                              controller: emailController,
                              obscureText: false, // hint text
                            ),

                            // Field
                            TextFieldWidget(
                              title: 'Password',
                              hintText: 'Enter your password',
                              controller: passwordController,
                              obscureText: true, // hint text
                            ),

                            // Sign up button
                            Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                color: yellowColor,
                                isLoading: isLoading,
                                child: const Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  String output =
                                      await authenticationMethods.signUpUser(
                                    name: nameController.text,
                                    address: addressController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (output == "success") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignInScreen(),
                                      ),
                                    );
                                  } else {
                                    Utils().showSnackBar(
                                      context: context,
                                      content: output,
                                    ); //show error
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Back button
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.6,
                        //fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInScreen();
                          },
                        ),
                      );
                    },
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
