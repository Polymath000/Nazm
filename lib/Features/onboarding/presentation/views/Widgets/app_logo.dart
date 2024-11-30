import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(
          image: AssetImage(
            'assets/images/Ellipse 88.png',
          ),
        ),
        Positioned(
          left: 23.5,
          bottom: 28,
          child: Image(
            image: AssetImage(
              'assets/images/Vector.png',
            ),
          ),
        ),
      ],
    );
  }
}
