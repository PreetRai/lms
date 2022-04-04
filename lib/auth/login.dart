import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/logo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _empLoginFormKey = GlobalKey<FormState>();
  String? errorMessage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.black12,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Enter your email',
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0)),
        border: const UnderlineInputBorder(),
      ),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please Enter a valid email';
        }
        return null;
      },
    );

    final passwordField = TextFormField(
      onEditingComplete: () {
        signIn(emailController.text, passwordController.text);
      },

      obscureText: true,
      autofocus: false,
      controller: passwordController,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        fillColor: Colors.black12,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Password',
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0)),
        border: const UnderlineInputBorder(),
      ),

      // The validator receives the text that the user has entered.
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _empLoginFormKey,
            child: Column(
              children: [
                Flex(direction: Axis.horizontal, children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 80,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Logo(),
                      ))
                ]),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login into your \nAccount',
                      style: TextStyle(fontSize: 35, color: Colors.black54),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        emailField,
                        passwordField,
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Login'),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_empLoginFormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/dashboard', (route) => false)
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be invalid.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        // ignore: avoid_print
        print(error.code);
      }
    }
  }

  getdata(String uid) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Employees').get();
    final List<DocumentSnapshot> document = result.docs;
    int x = document.length.toInt();
    print(x);
    List employee = <String>[];

    for (var i = 0; i < x; i++) {
      employee.add('${document.elementAt(i).get('uid')}');
    }

    var loggedin =
        employee.any((element) => element == uid) == true ? true : false;

    FirebaseFirestore.instance
        .collection('Employees')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('Employees')
            .doc(uid)
            .update({'uid': '${uid}'});
        Map<String, dynamic> employeess =
            documentSnapshot.data()! as Map<String, dynamic>;
        print('hello, ${employeess['firstName']}, ${employeess['uid']}');
      } else {
        print('Document does not exist on the database');
      }
    });
    print(employee);
  }
}
