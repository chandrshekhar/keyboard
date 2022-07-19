import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key, required this.height, required this.width, required this.text})
      : super(key: key);
  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10)
        ),
        height: height,
        width: width,

        child: Center(
            child: Text(text, style: const TextStyle(color: Colors.white),)),
      ),
    );
  }
}
