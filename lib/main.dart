import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/auth/login.dart';
import 'package:lms/auth/signup.dart';
import 'package:lms/home/welcome.dart';
import 'package:lms/screens/first_screen.dart';
import 'package:lms/screens/second_screen.dart';
import 'home/dashboard.dart';

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
        navigationBarTheme: const NavigationBarThemeData(),
        primaryTextTheme:
            const TextTheme(bodyText1: TextStyle(color: Colors.black)),
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)),
        primaryColor: const Color(0xFFC780BA),
        primaryColorLight: const Color(0xFFF6EAF4),
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color(0xFFF6EAF4),
        errorColor: Colors.red,
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              buttonColor: const Color(0xFFC780BA),
              colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: const Color(0xffC780BA),
                  secondary: const Color(0xFFF6EAF4)),
            ),
      );
    }

    return MaterialApp(
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/first' : '/dashboard',
        routes: {
          '/': (context) => const Welcome(),
          '/first': (context) => const FirstScreen(),
          '/second': (context) => const SecondScreen(),
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/dashboard': (context) => const DashBoard(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: _customTheme());
  }
}
