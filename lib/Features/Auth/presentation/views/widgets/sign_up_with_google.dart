import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';

class SignUpWithGoogle extends StatefulWidget {
  const SignUpWithGoogle({
    super.key,
  });

  @override
  State<SignUpWithGoogle> createState() => _SignUpWithGoogleState();
}

class _SignUpWithGoogleState extends State<SignUpWithGoogle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomeView(),
                ));
            ShowSnakBar(context, "I hope you enjoy our app.");
          } else if (state is SignupFailure) {
            ShowSnakBar(context, state.errorMessage);
          } else if (state is SignupLoading) {
          } else if (state is SignupInitial) {
          } else {
            ShowSnakBar(context, "There was an error ,please try again later");
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 40,
            margin: const EdgeInsets.only(top: 10),
            child: FilledButton(
              style: FilledButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () async {
                BlocProvider.of<SignupCubit>(context).signInWithGoogle();
              },
              child: const Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Image(image: AssetImage('assets/images/google.png')),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Sign Up with Google',
                    style: TextStyle(
                      color: Color(0XFF858fa9),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
