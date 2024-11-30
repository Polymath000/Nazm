import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({
    super.key,
    required this.text,
    required this.onPressed,
    
  });
  void Function()? onPressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: const Color(kPrimaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(kPrimaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
