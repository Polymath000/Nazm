import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class LogOutButtom extends StatelessWidget {
  const LogOutButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        visible: !isGuest && emailOfUser.isNotEmpty,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 1.8,
          child: CustomButtom(
            text: "Log Out",
            onPressed: () async {
              if (Hive.isBoxOpen(kTaskBox)) {
                await Hive.box<TaskModel>(kTaskBox).clear();
              }
              BlocProvider.of<SignupCubit>(context).signOut();
            },
          ),
        ),
      ),
    );
  }
}
