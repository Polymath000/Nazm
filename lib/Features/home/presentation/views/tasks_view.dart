import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/widgets/show_model_button_sheet.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_views_list.dart';
import '../../../../constants.dart';
import 'settings.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(taskViews[_selectedIndex]['title']),
          ),
          floatingActionButton: FloatingActionButton(
              tooltip: 'Add Task',
              enableFeedback: true,
              child: const Icon(Icons.add_task_sharp),
              onPressed: () {
                showModalBottomSheet(
                  barrierLabel: 'Task',
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  context: context,
                  builder: (context) => const ShowModelButtonSheet(),
                );
              }),
          body: taskViews[_selectedIndex]['View'],
          drawer: Drawer(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: AssetImage(testImage),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            testFullName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ),
                            );
                          },
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
                            numOftasks: taskViews[index]['numOftasks'],
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
    );
  }

  ListTile listTile(
      {required String title,
      required IconData icon,
      required int index,
      required int numOftasks,
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
          BlocProvider.of<TaskCubit>(context).fetchAllTasks();
        });
        _scaffoldKey.currentState!.closeDrawer();
      },
      trailing: Text(numOftasks.toString()),
    );
  }
}
