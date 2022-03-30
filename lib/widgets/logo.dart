import 'package:flutter/material.dart';

class Tlogo extends StatelessWidget {
  const Tlogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(direction: Axis.horizontal, children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/images/logo.png')),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'L-con',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        )
      ]),
    );
  }
}

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png');
  }
}
