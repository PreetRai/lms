import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/widgets/logo.dart';

import '../model/user_model.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _empFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final passwordEditingController = TextEditingController();
  final confirmEditingController = TextEditingController();
  final uidtexteditingcontroller = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    //password field
    final passwordSignUpField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordEditingController,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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
        border: UnderlineInputBorder(),
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

    //confirm password
    final confirmPasswordField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: confirmEditingController,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        fillColor: Colors.black12,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Confirm Password',
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0)),
        border: UnderlineInputBorder(),
      ),

      // The validator receives the text that the user has entered.
      validator: (value) {
        if (confirmEditingController.text != passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
    );

    final uidField = TextFormField(
      autofocus: false,
      controller: uidtexteditingcontroller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        uidtexteditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.black12,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Enter User ID',
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.0)),
        border: UnderlineInputBorder(),
      ),
    );
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _empFormKey,
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
                          )),
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
                      'Sign-up',
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
                        uidField,
                        passwordSignUpField,
                        confirmPasswordField,
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
                          getdata(uidtexteditingcontroller.text,
                              passwordEditingController.text);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sign up'),
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

  getdata(String uid, String password) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Employees').get();
    final List<DocumentSnapshot> document = result.docs;
    int x = document.length.toInt();
    print(x);
    List employee = <String>[];

    for (var i = 0; i < x; i++) {
      employee.add('${document.elementAt(i).get('uid')}');
    }

    // var loggedin =
    //     employee.any((element) => element == uid) == true ? true : false;

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
        //   print('hello, ${employeess['firstName']}, ${employeess['uid']}');
        String email = '${employeess['email']}';

        String firstName = '${employeess['firstName']}';
        String secondName = '${employeess['secondName']}';
        String jobTitle = '${employeess['jobtitle']}';
        String address = '${employeess['address']}';
        String phone = '${employeess['phone']}';
        String joiningDate = '${employeess['joininjdate']}';

        signUp(email, password, firstName, secondName, jobTitle, address, phone,
            joiningDate);
      } else {
        print('Document does not exist on the database');
      }
    });
    print(employee);
  }

  void signUp(
      String email,
      String password,
      String firstName,
      String secondName,
      String jobTitle,
      String address,
      String phone,
      String joiningDate) async {
    if (_empFormKey.currentState!.validate()) {
      String? uid = '';
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  uid = value.user!.uid,
                  postDetailsToFirestore(uid, email, firstName, secondName,
                      jobTitle, address, phone, joiningDate)
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
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

  postDetailsToFirestore(
      String? uid,
      String? email,
      String? firstName,
      String? secondName,
      String? jobTitle,
      String? address,
      String phone,
      String joiningDate) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    String ouid = uidtexteditingcontroller.text;
    EmpModel userModel = EmpModel();

    userModel.uid = uid;
    userModel.email = email;
    userModel.firstName = firstName;
    userModel.secondName = secondName;
    userModel.isAdmin = false;
    userModel.address = address;
    userModel.jobTile = jobTitle;
    userModel.phone = phone;
    userModel.joiningDate = joiningDate;
    await firebaseFirestore.collection("Employees").doc(ouid).delete();

    await firebaseFirestore
        .collection("Employees")
        .doc(uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }
}
