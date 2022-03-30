import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uidtexteditingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Center(
      child:Text('Login'),
    ));
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
