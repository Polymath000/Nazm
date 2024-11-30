import 'package:flutter/material.dart';

class AddTaskButtom extends StatelessWidget {
  AddTaskButtom({super.key, required this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Add Task",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
