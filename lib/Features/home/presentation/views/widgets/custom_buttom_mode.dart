import 'package:flutter/material.dart';

class CustomButtomMode extends StatelessWidget {
  const CustomButtomMode({
    super.key,
    required this.text,
    required this.borderRadius,
    required this.onPressed,
    required this.index,
  });
  final String text;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onPressed;
  final int index;

  @override
  Widget build(BuildContext context) {
    int currentIndex = getindex(text);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 37),
        height: 48,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: currentIndex == index
                ? Colors.blue
                : Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: borderRadius,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  getindex(String text) {
    if (text == "Dark") {
      return 0;
    } else if (text == "Light") {
      return 1;
    } else {
      return 2;
    }
  }
}
