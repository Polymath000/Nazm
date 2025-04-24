import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/Auth/presentation/views/log_in_view.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class DeleteAccountButtom extends StatefulWidget {
  DeleteAccountButtom(
      {super.key, required this.isLoading, required this.updateIsLoading});
  bool isLoading;
  Function(bool) updateIsLoading;
  @override
  State<DeleteAccountButtom> createState() => _DeleteAccountButtomState();
}

class _DeleteAccountButtomState extends State<DeleteAccountButtom> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isGuest && emailOfUser.isNotEmpty,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 1.5,
        child: CustomButtom(
          colorButtom: Colors.deepPurple,
          text: "Delete Account",
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return Stack(
                  children: [
                    AlertDialog(
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
                            Navigator.of(dialogContext).pop();
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
                            Navigator.pop(context);
                            setState(() {
                              widget.isLoading = true;
                              widget.updateIsLoading(widget.isLoading);
                            });
                            final bool isConnected =
                                await InternetConnectionChecker
                                    .instance.hasConnection;

                            if (isConnected && emailOfUser.isNotEmpty) {
                              await context.read<SignupCubit>().deleteAccount();

                              CollectionReference collection = FirebaseFirestore
                                  .instance
                                  .collection(emailOfUser);
                              var snapshots = await collection.get();
                              for (var doc in snapshots.docs) {
                                await doc.reference.delete();
                              }
                              if (Hive.isBoxOpen(kTaskBox)) {
                                await Hive.box<TaskModel>(kTaskBox).clear();
                              }

                              if (mounted) {
                                setState(() {
                                  widget.isLoading = false;
                                  widget.updateIsLoading(widget.isLoading);
                                });
                              }

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInView(),
                                  ));
                            } else {
                              if (mounted) {
                                setState(() {
                                  widget.isLoading = false;
                                  widget.updateIsLoading(widget.isLoading);
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Connection lost",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    if (widget.isLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
