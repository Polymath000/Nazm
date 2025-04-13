import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/presentation/views/edit_profile.dart';
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

  final ProfileImageController _imageController = ProfileImageController();
  late final TaskCubit _taskCubit;

  @override
  void initState() {
    super.initState();
    _taskCubit = TaskCubit();
    _initializeProfileImage();
  }

  @override
  void dispose() {
    _taskCubit.close();
    super.dispose();
  }

  Future<void> _initializeProfileImage() async {
    await _imageController.loadSavedImage();
    setState(() {});
  }

  void GoToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
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
                  builder: (context) => ShowModelButtonSheet(date: DateTime.now(),),
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
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundImage:
                              _imageController.selectedImage != null
                                  ? FileImage(_imageController.selectedImage!)
                                  : AssetImage(userImage) as ImageProvider,
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
                          onPressed: GoToSettings,
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
