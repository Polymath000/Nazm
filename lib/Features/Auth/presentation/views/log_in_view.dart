import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do/Features/Auth/Data/manager/login_cubit/login_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/forget_password.dart';
import 'package:to_do/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/main_custom_buttom.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/or_divider.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/password_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/sign_up_with_facebook.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/sign_up_with_google.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';
import 'package:to_do/constants.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                isLoading = false;
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeView(),
                ));
                ShowSnakBar(context, "Welcome back.");
              } else if (state is LoginFailure) {
                isLoading = false;
                ShowSnakBar(context, state.errorMessage);
              } else if (state is LoginLoading) {
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
                      key: formKey,
                      child: ListBody(
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Row(
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
                          MainCustomButtom(
                            text: 'Log In',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context)
                                    .signInWithEmailAndPassword(
                                        email: email!, password: password!);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const OrDivider(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SignUpWithGoogle(),
                              SignUpWithFacebook(),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPassword(),
                                      ));
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Don\'t have an account? ',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 54, 41, 41)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpView(),
                                          ));
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ));
                            },
                            child: Row(
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  'Login as guest',
                                  style: GoogleFonts.playfair(
                                      fontSize: 20,
                                      textStyle: TextStyle(
                                        color: Colors.indigo,
                                      )),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
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
      ),
    ]);
  }
}
