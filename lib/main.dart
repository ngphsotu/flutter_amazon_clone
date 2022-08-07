import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/utils/color_themes.dart';
import '/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: "1:526366378423:web:cbefd2846209d1fa874032",
        apiKey: "AIzaSyC0qnp91_QhqrT9k7v1v9p4vnUnQQk6DtM",
        projectId: "ac-11a11",
        authDomain: "ac-11a11.firebaseapp.com",
        measurementId: "G-9DBKRJ20R2",
        storageBucket: "ac-11a11.appspot.com",
        messagingSenderId: "526366378423",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon Clone",
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else if (user.hasData) {
            return const Text('signed in');
          } else {
            return const SignInScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
