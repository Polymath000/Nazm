import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom(
      {super.key,
      required this.text,
      required this.onPressed,
      this.colorButtom = const Color(kPrimaryColor)});
  void Function()? onPressed;
  Color colorButtom;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: colorButtom,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: colorButtom,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
      ),
    );
  }
}
