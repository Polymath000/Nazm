// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/main_custom_buttom.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/password_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';
import 'package:to_do/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? email;
  String? password;
  String? confirmPassword;
  String? userName;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  // AutovalidateMode autoValidate = AutovalidateMode.always;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/back4.jpeg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                isLoading = false;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ));
                ShowSnakBar(context, "I hope you enjoy our app.");
              } else if (state is SignupFailure) {
                isLoading = false;
                ShowSnakBar(context, state.errorMessage);
              } else if (state is SignupLoading) {
                isLoading = true;
              } else {
                isLoading = false;
                ShowSnakBar(
                    context, "There was an error ,please try again later");
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                blur: 0.6,
                dismissible: false,
                inAsyncCall: isLoading,
                progressIndicator: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.pacman,
                    colors: kPrimaryLoading,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      // autovalidateMode: autoValidate,
                      key: formKey,
                      child: ListBody(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(kLargeLogo),
                                height: 180,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            // TODO : add username to database
                            hintText: 'Full Name',

                            onChanged: (String Name) {
                              userName = Name;
                            },
                          ),
                          CustomTextField(
                            hintText: 'Email Address',
                            onChanged: (String Email) {
                              email = Email;
                            },
                          ),
                          PasswordTextField(
                            hintText: 'Password',
                            onChanged: (String Password) {
                              password = Password;
                            },
                          ),
                          PasswordTextField(
                            hintText: 'Confirm Password',
                            onChanged: (String Confirm_Password) {
                              confirmPassword = Confirm_Password;
                            },
                          ),
                          MainCustomButtom(
                            text: 'Sign Up',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<SignupCubit>(context)
                                    .createNewUser(
                                  email: email!,
                                  password: password!,
                                  userName: userName!,
                                  confirmPassword: confirmPassword!,
                                );
                              }
                              isLoading = false;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
