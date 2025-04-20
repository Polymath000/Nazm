import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/log_in_view.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/loading_progress_h_u_d.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/show_snak_bar.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/home/presentation/views/home_view.dart';
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
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DarkOrlight(index, context),
                  BlocConsumer<SignupCubit, SignupState>(
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
                      return Column(
                        children: [
                          Visibility(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.5,
                              child: CustomButtom(
                                colorButtom: Colors.deepPurple,
                                text: "Delete Account",
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      bool isLoading = false;
                                      return LoadingProgressHUD(
                                        isLoading: isLoading,
                                        child: AlertDialog(
                                          title: const Text(
                                            'Delete your Account?',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: const Text(
                                              '''If you select Delete we will delete your account on our server.
                                        
                                        Your app data will also be deleted and you won't be able to retrieve it.
                                        
                                        Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(dialogContext)
                                                    .pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                final signupCubit =
                                                    context.read<SignupCubit>();
                                                signupCubit.deleteAccount();
                                                final bool isConnected =
                                                    await InternetConnectionChecker
                                                        .instance.hasConnection;

                                                if (isConnected &&
                                                    emailOfUser.isNotEmpty) {
                                                  CollectionReference
                                                      collection =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              emailOfUser);
                                                  var snapshots =
                                                      await collection.get();
                                                  for (var doc
                                                      in snapshots.docs) {
                                                    await doc.reference
                                                        .delete();
                                                  }
                                                  if (Hive.isBoxOpen(
                                                      kTaskBox)) {
                                                    await Hive.box<TaskModel>(
                                                            kTaskBox)
                                                        .clear();
                                                  }

                                                  setState(() {
                                                    isLoading = false;
                                                  });

                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LogInView(),
                                                      ));
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          "Connection lost",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.8,
                              child: CustomButtom(
                                text: "Log Out",
                                onPressed: () async {
                                  if (Hive.isBoxOpen(kTaskBox)) {
                                    await Hive.box<TaskModel>(kTaskBox).clear();
                                  }
                                  BlocProvider.of<SignupCubit>(context)
                                      .signOut();
                                },
                              ),
                            ),
                          ),
                        ],
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

  Row DarkOrlight(int index, BuildContext context) {
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
