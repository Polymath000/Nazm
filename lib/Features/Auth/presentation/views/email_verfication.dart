import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/main_custom_buttom.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailVerificationCubit(),
      child: Scaffold(
        body: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
          listener: (context, state) {
            if (state is EmailVerificationSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeView(),
              ));
              ShowSnakBar(context, "Success");
            } else if (state is EmailVerificationFailure) {
              ShowSnakBar(context, state.errorMessage);
            } else if (state is EmailVerificationLoading) {
              ShowSnakBar(context, "Check Inbox!");
            } else {
              ShowSnakBar(
                  context, "There was an error ,please try again later");
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 3.3,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage('assets/images/Group 11872.png')),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 35, bottom: 24.0),
                      child: Text(
                        'Email Verification',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Opacity(
                        opacity: 0.8,
                        child: Text(
                          'We will send to you a link to verificate your email.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff202D41),
                          ),
                        ),
                      ),
                    ),
                    MainCustomButtom(
                        text: 'Send',
                        onPressed: () async {
                          BlocProvider.of<EmailVerificationCubit>(context)
                              .checkEmail();
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
