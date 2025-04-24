import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Features/Auth/Data/manager/login_cubit/login_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/forget_password.dart';
import 'package:to_do/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/main_custom_buttom.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/or_divider.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/password_text_field.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/sign_up_with_google.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';
import 'package:to_do/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Form(
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
            label: 'Email',
            validatorRequired: true,
          ),
          PasswordTextField(
            hintText: 'Password',
            onChanged: (String Password) {
              password = Password;
            },
            label: 'password',
          ),
          MainCustomButtom(
            text: 'Log In',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                emailOfUser = email ?? "";

                CollectionReference collection =
                    FirebaseFirestore.instance.collection(emailOfUser);

                var snapshots = await collection.get();
                for (var doc in snapshots.docs) {
                  Map<String, dynamic> data = {};
                  await doc.reference.get().then((DocumentSnapshot doc) {
                    data.addAll(doc.data() as Map<String, dynamic>);
                  });

                  TaskModel task;
                  task = TaskModel(
                    title: data['Title'] ?? '',
                    description: data['description'] ?? '',
                    isDone: data['isDone'] ?? false,
                    firstDate: data['firstDate'] ?? DateTime.now().toString(),
                    priority: data['priority'] ?? kPrimaryPriority,
                  );
                  BlocProvider.of<AddTaskCubit>(context).addTask(task);
                }
                BlocProvider.of<LoginCubit>(context).signInWithEmailAndPassword(
                    email: email!, password: password!);
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const OrDivider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Fix the problem of this option

              SignUpWithGoogle(),
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
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  GestureDetector(
                    onTap: () {
                      isGuest = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
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
              isGuest = true;
              emailOfUser = "";
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
    );
  }
}
