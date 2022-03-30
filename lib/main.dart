import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/auth/login.dart';
import 'package:lms/auth/signup.dart';
import 'package:lms/home/welcome.dart';
import 'package:lms/screens/first_screen.dart';
import 'package:lms/screens/second_screen.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _customTheme() {
      return ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: Color(0xFFC780BA),
        buttonColor: Color(0xFFC780BA),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Color(0xffcF6EAF),
        errorColor: Colors.red,
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              buttonColor: Color(0xFFC780BA),
              colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: Color(0xffC780BA), secondary: Color(0xffD9A2CF)),
            ),
      );
    }

    return MaterialApp(
        initialRoute: '/welcome',

        //FirebaseAuth.instance.currentUser== null? '/Login':'/Dashboard',
        routes: {
          '/': (context) => const MyHomePage(),
          '/welcome': (context) => const Welcome(),
          '/first': (context) => const FirstScreen(),
          '/second': (context) => const SecondScreen(),
          '/Login': (context) => const Login(),
          '/Signup': (context) => const Signup(),
          '/dashboard': (context) => const MyHomePage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: _customTheme());
  }
}
