import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(title.toString()),
      actions: const [
        Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.notifications)),
      ],
      elevation: 1,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
