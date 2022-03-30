import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            size: 15,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('jhon',
                              style:  TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          Text(
                            'hopkin',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                            textScaleFactor: 0.8,
                          )
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => const DashBoard()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Dashboard',
                          ),
                          Icon(Icons.dashboard)
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => const Employeedetails()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Employees',
                          ),
                          Icon(Icons.emoji_people_outlined)
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //       builder: (context) => const Contactsdetails()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Contacts',
                          ),
                          Icon(Icons.contact_page)
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      //      Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //          builder: (context) => const Opportunities()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Opportunities',
                        ),
                        Icon(Icons.group_add)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        //   logout(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Logout'),
                          Icon(
                            Icons.logout,
                            size: 15,
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
