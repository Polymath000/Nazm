import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/settings.dart';
import 'package:to_do/constants.dart';

class AppBarOfProfile extends StatelessWidget {
  const AppBarOfProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          const Image(
            image: AssetImage(kSmallLogo),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ));
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
