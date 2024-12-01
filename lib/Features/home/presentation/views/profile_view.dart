import 'package:flutter/material.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/home/presentation/views/edit_profile.dart';
import 'package:to_do/Features/home/presentation/views/widgets/app_bar_of_profile.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          children: [
            const AppBarOfProfile(),
            const CircleAvatar(
              maxRadius: 77,
              backgroundColor: Color.fromARGB(255, 167, 155, 155),
              child: CircleAvatar(
                maxRadius: 75,
                backgroundImage: AssetImage('assets/images/me.png'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              height: 55,
              child: CustomButtom(
                text: "Edit Profile",
                
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EditProfile(),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              hintText: "Full Name",
              onChanged: (Sting) {},
              enabled: false,
            ),
            CustomTextField(
              hintText: "Email Address",
              onChanged: (Sting) {},
              enabled: false,
            ),
            CustomTextField(
              hintText: "Phone Number",
              onChanged: (Sting) {},
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
