import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/calender_view.dart';
import 'package:to_do/Features/home/presentation/views/tasks_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: getSelectedWidget(
            index: index,
            isLoading: isLoading,
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationCurve: Curves.easeInOut,
        backgroundColor: Colors.transparent,
        // Theme.of(context).scaffoldBackgroundColor,
        buttonBackgroundColor: const Color.fromARGB(255, 44, 101, 187),
        color: const Color.fromARGB(255, 44, 101, 187),
        animationDuration: const Duration(milliseconds: 350),
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        index: index,
        items: const [
          Icon(Icons.calendar_month, size: 20, color: Colors.black),
          Icon(Icons.task_alt, size: 20, color: Colors.black),
          // Icon(Icons.person, size: 20, color: Colors.black),
        ],
      ),
    );
  }

  Widget getSelectedWidget({required int index, required bool isLoading}) {
    switch (index) {
      case 0:
        return const CalenderView();
      default:
        return const TasksView();
      // default:
      //   return ProfileView();
    }
  }
}
