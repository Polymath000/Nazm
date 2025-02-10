import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField(
      {super.key, required this.hintText, required this.onChanged});
  final String hintText;
  void Function(String)? onChanged;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        onChanged: widget.onChanged,
        obscureText: !isShow,
        decoration: InputDecoration(
          helperStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          hintText: '**************',
          labelStyle: TextStyle(color: Colors.black),
          floatingLabelStyle: TextStyle(color: Colors.black),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isShow ? isShow = false : isShow = true;
              });
            },
            icon: Icon(
              isShow ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              color: Colors.black,
            ),
          ), // remove_red_eye_sharp
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 84, 96, 104),
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
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 123, 77, 77),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
