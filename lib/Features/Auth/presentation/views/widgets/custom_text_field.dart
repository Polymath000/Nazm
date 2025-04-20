import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.enabled = true,
      this.color = Colors.black});
  Color color;
  final String hintText;
  void Function(String)? onChanged;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style: TextStyle(color: color),
        validator: (data) {
          if (data!.isEmpty) {
            return 'value is empty';
          }
          if (hintText == "Email Address") {
            if (!data.contains('@')) {
              return 'the email is not valid';
            }
          }
          return null;
        },
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
          helperStyle: TextStyle(color: color),
          labelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(255, 0, 0, 0)
                : Colors.white,
          ),
          floatingLabelStyle: TextStyle(color: color),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 84, 96, 104),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 84, 96, 104),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 1, 161, 253),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 123, 77, 77),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: hintText,
          hintStyle: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
