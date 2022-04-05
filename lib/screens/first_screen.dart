import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Flex(
                  mainAxisAlignment: MainAxisAlignment.end,
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                        child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Container(
                      height: 5,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(5)),
                    )),
                    const Spacer(),
                    Flexible(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Skip',
                              style: TextStyle(color: Colors.black),
                            )))
                  ]),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Attract Your Customer',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w100),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/firstscreenimage.png'),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/backimg2.png'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    },
                    child: const Text('Next')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
