import 'package:flutter/material.dart';
import 'package:to_do/Features/onboarding/data/models/onboarding_model.dart';
import 'package:to_do/constants.dart';

class BuildDot extends StatelessWidget {
  BuildDot({super.key, required this.indexOfPage});
  int indexOfPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(OnboardingList.length, (index) {
        return Container(
          margin: const EdgeInsets.only(left: 15),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: indexOfPage == index
                  ? const Color(kPrimaryColor)
                  : Colors.grey),
        );
      }),
    );
  }
}
