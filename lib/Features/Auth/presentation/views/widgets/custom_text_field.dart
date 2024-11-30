import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.enabled = true});
  final String hintText;
  void Function(String)? onChanged;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
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
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 166, 171, 174),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 166, 171, 174),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 2, 61, 119),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 123, 77, 77),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xff8f96a0),
            )),
      ),
    );
  }
}
