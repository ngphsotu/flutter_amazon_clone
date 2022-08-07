import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/utils/constants.dart';
import '/utils/color_themes.dart';
import '/screens/sign_up_screen.dart';
import '/widgets/text_field_widget.dart';
import '/widgets/custom_main_button.dart';
import '/resources/authentication_methods.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

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
                  // Logo
                  Image.network(amazonLogo, height: screenSize.height * 0.10),

                  //
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
                        // Text - Sign in
                        const Text(
                          'Sign-In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 33),
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

                        // Sign in button
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                            color: yellowColor,
                            isLoading: isLoading,
                            child: const Text(
                              'Sign-In',
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
                                  await authenticationMethods.signInUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              if (output == 'success') {
                                //funcitons
                              } else {
                                // show error
                                Utils().showSnackBar(
                                  context: context,
                                  content: output,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Line & Text
                  Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: Colors.grey),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'New to Amazon?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(height: 1, color: Colors.grey),
                      ),
                    ],
                  ),

                  // Cteate Button
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    child: const Text(
                      'Create an Amazon Account',
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
                            return const SignUpScreen();
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
