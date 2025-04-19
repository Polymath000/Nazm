import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/log_in_view.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/presentation/views/widgets/custom_buttom_mode.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    int index = AdaptiveTheme.of(context).mode.isDark
        ? 0
        : (AdaptiveTheme.of(context).mode.isLight ? 1 : 2);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomButtomMode(
                    index: index,
                    text: 'Dark',
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                      AdaptiveTheme.of(context).setDark();
                    },
                  ),
                  CustomButtomMode(
                    index: index,
                    text: 'System',
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0),
                    ),
                    onPressed: () {
                      setState(() {
                        index = 2;
                      });
                      AdaptiveTheme.of(context).setSystem();
                    },
                  ),
                  CustomButtomMode(
                    index: index,
                    text: 'Light',
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                      AdaptiveTheme.of(context).setLight();
                    },
                  ),
                ],
              ),
              BlocProvider(
                create: (context) => SignupCubit(),
                child: BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInView(),
                          ));
                    } else if (state is SignupFailure) {
                      ShowSnakBar(context, state.errorMessage);
                    } else if (state is SignupLoading) {
                    } else {
                      ShowSnakBar(context,
                          "There was an error ,please try again later");
                    }
                  },
                  builder: (context, state) {
                    return Visibility(
                      visible: isGuest,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.8,
                        child: CustomButtom(
                          text: "Log Out",
                          onPressed: () {
                            BlocProvider.of<SignupCubit>(context).signOut();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              // TODO: add buttom to signup and upload tasks to firebase
            ],
          ),
        ),
      ),
    );
  }
}
