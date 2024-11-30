import 'package:flutter/material.dart';

class SignUpWithFacebook extends StatelessWidget {
  const SignUpWithFacebook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      margin: const EdgeInsets.only(top: 10),
      child: FilledButton(
        style: FilledButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(0)),
        onPressed: () {},
        child: const Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Image(image: AssetImage('assets/images/facebook.png')),
            SizedBox(
              width: 7,
            ),
            Text(
              'Sign Up with Facebook',
              style: TextStyle(
                color: Color(0XFF858fa9),
                fontSize: 12,
              ),
            ),
            SizedBox(
              width: 7,
            ),
          ],
        ),
      ),
    );
  }
}
