import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/log_in_view.dart';
import 'package:to_do/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/loading_progress_h_u_d.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/presentation/views/widgets/custom_buttom_mode.dart';
import 'package:to_do/Features/home/presentation/views/widgets/delete_account_buttom.dart';
import 'package:to_do/Features/home/presentation/views/widgets/delete_data_only_bottom.dart';
import 'package:to_do/Features/home/presentation/views/widgets/log_out_buttom.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = false;

  void updateIsLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = AdaptiveTheme.of(context).mode.isDark
        ? 0
        : (AdaptiveTheme.of(context).mode.isLight ? 1 : 2);

    return Scaffold(
      body: LoadingProgressHUD(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocProvider(
            create: (context) => SignupCubit(),
            child: Builder(
              builder: (context) => Column(
                children: [
                  darkOrlight(index, context),
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInView(),
                            ));
                      } else if (state is SignupFailure) {
                        setState(() {
                          isLoading = false;
                        });
                        ShowSnakBar(context, state.errorMessage);
                      } else if (state is SignupLoading) {
                        setState(() {
                          isLoading = true;
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ShowSnakBar(context,
                            "There was an error ,please try again later");
                      }
                    },
                    builder: (context, state) {
                      return Expanded(
                        // flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DeleteDataOnlyBottom(
                              isLoading: isLoading,
                              updateIsLoading: updateIsLoading,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DeleteAccountButtom(
                              isLoading: isLoading,
                              updateIsLoading: updateIsLoading,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SignUpButton(),
                            SizedBox(
                              height: 20,
                            ),
                            LogOutButtom(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row darkOrlight(int index, BuildContext context) {
    return Row(
      children: [
        CustomButtomMode(
          index: index,
          text: 'Dark',
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
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
              topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
          onPressed: () {
            setState(() {
              index = 1;
            });
            AdaptiveTheme.of(context).setLight();
          },
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isGuest && emailOfUser.isEmpty,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 1.5,
        child: CustomButtom(
          colorButtom: const Color.fromARGB(255, 74, 244, 125),
          text: "Sign Up",
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpView(),
                ));
          },
        ),
      ),
    );
  }
}
