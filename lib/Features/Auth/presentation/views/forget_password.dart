import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do/Features/Auth/Data/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  String? email;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/back7.jpeg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                isLoading = false;
                Navigator.pop(context);
                ShowSnakBar(context, "Please check your inbox");
              } else if (state is ForgetPasswordFailure) {
                isLoading = false;
                ShowSnakBar(context, state.errorMessage);
              } else if (state is ForgetPasswordLoading) {
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
                dismissible: true,
                inAsyncCall: isLoading,
                progressIndicator: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.pacman,
                    colors: kPrimaryLoading,
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 8,
                            ),
                            const Image(
                              image: AssetImage(
                                kMedLogo,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 120,
                            ),
                            const Text(
                              "Enter email to send you a reset message to reset your password",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              onChanged: (String Email) {
                                email = Email;
                              },
                              label: 'Email',
                              validatorRequired: true,
                            ),
                            CustomButtom(
                              text: "Send",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<ForgetPasswordCubit>(context)
                                      .resetPasswordWithEmail(email: email!);
                                }
                              },
                            )
                          ],
                        ),
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
