import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lms/extentions/string_extension.dart';
import '../model/user_model.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  EmpModel loggedinAdmin = EmpModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Employees")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinAdmin = EmpModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        width: 80,
                        height: 80,
                        child: FittedBox(
                            child: Image.asset(
                          'assets/images/jh.png',
                          fit: BoxFit.fill,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${loggedinAdmin.firstName.toString().toCapitalized()}'
                                ' ${loggedinAdmin.secondName.toString().toCapitalized()}',
                                style: const TextStyle(
                                  fontSize: 20,
                                )),
                            Text(
                              '${loggedinAdmin.email}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w100),
                              textScaleFactor: 0.8,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 16.0),
                            child: Icon(Icons.dashboard, color: Colors.black),
                          ),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => const Employeedetails()));
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 16.0),
                            child: Icon(Icons.emoji_people_outlined,
                                color: Colors.black),
                          ),
                          Text('Employees',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //       builder: (context) => const Contactsdetails()));
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 16.0),
                            child:
                                Icon(Icons.contact_page, color: Colors.black),
                          ),
                          Text('Contacts',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      //      Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //          builder: (context) => const Opportunities()));
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 16.0),
                          child: Icon(Icons.group_add, color: Colors.black),
                        ),
                        Text('Opportunities',
                            style: TextStyle(
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 16.0),
                          child: Icon(Icons.exit_to_app, color: Colors.black),
                        ),
                        Text('Logout',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/');
  }
}
