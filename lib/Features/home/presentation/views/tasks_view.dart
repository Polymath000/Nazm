import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/show_model_button_sheet.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_views_list.dart';
import 'settings.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final TaskCubit _taskCubit;

  @override
  void initState() {
    super.initState();
    _taskCubit = TaskCubit();
  }

  @override
  void dispose() {
    _taskCubit.close();
    super.dispose();
  }

  void goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocProvider.value(
        value: _taskCubit,
        child: Builder(
          builder: (context) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(taskViews[_selectedIndex]['title']),
            ),
            floatingActionButton: FloatingActionButton(
                tooltip: 'Add Task',
                enableFeedback: true,
                autofocus: true,
                onPressed: () {
                  _taskCubit.fetchAllTasks();
                  showModalBottomSheet(
                    barrierLabel: 'Task',
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    context: context,
                    builder: (context) => ShowModelButtonSheet(
                      date: DateTime.now(),
                    ),
                  );
                },
                child: const Icon(Icons.add_task_sharp)),
            body: taskViews[_selectedIndex]['View'],
            drawer: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              BlocProvider.of<SignupCubit>(context)
                                  .getUserName(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: goToSettings,
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: taskViews.length,
                        itemBuilder: (context, index) {
                          return listTile(
                              title: taskViews[index]['title'],
                              icon: taskViews[index]['icon'],
                              index: index,
                              selectedIndex: _selectedIndex,
                              context: context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile listTile(
      {required String title,
      required IconData icon,
      required int index,
      required int selectedIndex,
      required BuildContext context}) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedIndex == index ? Colors.orange : Colors.grey,
      ),
      title: Text(title),
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _taskCubit.fetchAllTasks();
        });
        _scaffoldKey.currentState!.closeDrawer();
      },
    );
  }
}
