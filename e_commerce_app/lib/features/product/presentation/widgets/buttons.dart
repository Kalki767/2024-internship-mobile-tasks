import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String navigateto;
  final IconData icons;

  final Color colors;

  const Buttons({
    super.key,
    required this.navigateto,
    this.colors = Colors.white,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icons,
        color: colors,
      ),
      onPressed: () {
        Navigator.pushNamed(context, navigateto);
      },
    );
  }
}
