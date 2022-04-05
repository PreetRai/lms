import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lms/extentions/string_extension.dart';
import 'package:lms/widgets/app_bar.dart';
import 'package:lms/widgets/app_drawer.dart';

import '../model/user_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  User? user = FirebaseAuth.instance.currentUser;
  EmpModel loggedinemployee = EmpModel();
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("Employees")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinemployee = EmpModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? email = loggedinemployee.email;
    String? name =
        '${loggedinemployee.firstName.toString().toCapitalized()} ${loggedinemployee.secondName.toString().toCapitalized()}';
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Dashboard'),
        drawer: AppDrawer(name: name, email: email),
        body: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.add_to_photos_outlined),
                                  ),
                                  Text(
                                    'Total Leads',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '15',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
                Flexible(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.group_add_outlined),
                                  ),
                                  Text(
                                    'New Leads',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.white,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'New Leads',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
