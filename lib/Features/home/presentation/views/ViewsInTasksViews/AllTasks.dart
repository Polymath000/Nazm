import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/task_body.dart';

import '../widgets/priority.dart';

class AllTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              TaskBody(),
              TaskBody(),
              TaskBody(),
              TaskBody(),
              TaskBody(),
              TaskBody(),
            ],
          ),
        ),
      ),
    );
  }
}
