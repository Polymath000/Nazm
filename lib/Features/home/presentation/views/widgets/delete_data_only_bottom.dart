import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'package:to_do/constants.dart';

class DeleteDataOnlyBottom extends StatefulWidget {
  DeleteDataOnlyBottom(
      {super.key, required this.isLoading, required this.updateIsLoading});
  bool isLoading;
  Function(bool) updateIsLoading;
  @override
  State<DeleteDataOnlyBottom> createState() => _DeleteDataOnlyBottomState();
}

class _DeleteDataOnlyBottomState extends State<DeleteDataOnlyBottom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 1.5,
      child: CustomButtom(
        colorButtom: const Color.fromARGB(255, 11, 39, 53),
        text: "Delete Data Only",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return Stack(
                children: [
                  AlertDialog(
                    title: const Text(
                      'Delete your Data?',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(
                        '''If you select Delete we will delete your Data ${isGuest ? "" : " on our server"}.'''),
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

                          if (Hive.isBoxOpen(kTaskBox)) {
                            await Hive.box<TaskModel>(kTaskBox).clear();
                          }

                          final bool isConnected =
                              await InternetConnectionChecker
                                  .instance.hasConnection;

                          if (isConnected && emailOfUser.isNotEmpty) {
                            CollectionReference collection = FirebaseFirestore
                                .instance
                                .collection(emailOfUser);
                            var snapshots = await collection.get();
                            for (var doc in snapshots.docs) {
                              await doc.reference.delete();
                            }
                            if (mounted) {
                              setState(() {
                                widget.isLoading = false;
                                widget.updateIsLoading(widget.isLoading);
                              });
                            }
                            Navigator.pop(context);
                          } else if (emailOfUser.isEmpty) {
                            if (mounted) {
                              setState(() {
                                widget.isLoading = false;
                                widget.updateIsLoading(widget.isLoading);
                              });
                            }
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
    );
  }
}
