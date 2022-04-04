import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    SizedBox(
                      width: 100,
                      child: Row(children: [
                        Flexible(
                            child: Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(5)),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )),
                      ]),
                    ),
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
                  'Get Total Customer Data',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w100),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/secondscreenimage.png'),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/backimg.png'),
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
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('Next')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
