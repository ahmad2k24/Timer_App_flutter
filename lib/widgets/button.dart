import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double height, width;
  final Color color;
  final String title;
  final VoidCallback onTap;
  const Button(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
