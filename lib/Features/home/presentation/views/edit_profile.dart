import 'package:flutter/material.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/home/presentation/views/widgets/app_bar_of_profile.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 23, top: 39),
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
                    CustomTextField(
                      hintText: "Full Name",
                      onChanged: (Sting) {},
                    ),
                    CustomTextField(
                      hintText: "Email Address",
                      onChanged: (Sting) {},
                    ),
                    CustomTextField(
                      hintText: "Phone Number",
                      onChanged: (Sting) {},
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.9,
                      child: CustomButtom(
                        text: "Save",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ))));
  }
}
