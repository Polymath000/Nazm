import 'package:flutter/material.dart';
import 'package:to_do/Features/Auth/presentation/views/log_in_view.dart';
import 'package:to_do/Features/onboarding/data/models/onboarding_model.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/build_dot.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

// ignore: camel_case_types
class _onboardingState extends State<onboarding> {
  int currentindex = 0;
  PageController _controller = PageController(initialPage: 0);
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(children: [
              PageView.builder(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    currentindex = value;
                  });
                },
                itemCount: OnboardingList.length,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height / 2,
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.only(top: 100),
                        child: Image.asset(OnboardingList[i].imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: Text(
                          OnboardingList[i].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                  top: MediaQuery.sizeOf(context).height / 1.4,
                  left: MediaQuery.sizeOf(context).width / 2.5,
                  child: Column(
                    children: [
                      BuildDot(
                        indexOfPage: currentindex,
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  )),
              Positioned(
                top: MediaQuery.sizeOf(context).height / 1.3,
                left: MediaQuery.sizeOf(context).width / 6,
                child: CustomButtom(
                  text: OnboardingList[currentindex].buttomText,
                  onPressed: () {
                    if (currentindex == OnboardingList.length - 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInView(),
                          ));
                    }
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceIn);
                  },
                ),
              ),
              Positioned(
                  top: MediaQuery.sizeOf(context).height / 1.1,
                  left: MediaQuery.sizeOf(context).width / 2.3,
                  child: TextButton(
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInView(),
                          ));
                    },
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
