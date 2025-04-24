import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/login_cubit/login_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/loading_progress_h_u_d.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/login_form.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/data/cubit/add_task/add_task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/back6.jpg',
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
              return LoadingProgressHUD(
                isLoading: isLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: BlocProvider(
                      create: (context) => AddTaskCubit(),
                      child: LoginForm(),
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
