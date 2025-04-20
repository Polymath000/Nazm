import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';
import 'package:to_do/constants.dart';

class TaskRow extends StatefulWidget {
  TaskRow({super.key, required this.task});
  TaskModel task;

  @override
  _TaskRowState createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  late bool isCompleted;
  TaskCubit? _taskCubit;
  late AudioPlayer? player;
  Color getPriorityColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      if (widget.task.priority.contains('High')) {
        return Color(0xFFFF6B6B);
      } else if (widget.task.priority.contains('Meduim')) {
        return Color(0xFFFFD93D);
      } else if (widget.task.priority.contains('Low')) {
        return Color(0xFF4DABF7);
      }
      return Colors.grey.shade400;
    } else {
      if (widget.task.priority.contains('High')) {
        return Color(0xFFDC3545);
      } else if (widget.task.priority.contains('Meduim')) {
        return Color(0xFFFFC107);
      } else if (widget.task.priority.contains('Low')) {
        return Color(0xFF0D6EFD);
      }
      return Colors.grey.shade600;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _taskCubit = BlocProvider.of<TaskCubit>(context);
  }

  @override
  void dispose() {
    player?.dispose();

    super.dispose();
  }

  @override
  initState() {
    super.initState();
    isCompleted = widget.task.isDone;
    player = AudioPlayer();
  }

  Future<void> _play() async {
    player?.stop();
    player?.resume();
    await player?.play(AssetSource('audio/finish.mp3'));
  }

  void _handleTaskCompletion() async {
    if (!isCompleted) {
      await _play();
    }

    setState(() {
      isCompleted = !isCompleted;
      widget.task.isDone = isCompleted;
    });
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;

    if (isConnected && emailOfUser.isNotEmpty) {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(emailOfUser);
      await collection.doc(widget.task.title + widget.task.firstDate).delete();
      collection.doc(widget.task.title + widget.task.firstDate.toString()).set({
        "Title": widget.task.title,
        "firstDate": widget.task.firstDate.toString(),
        "description": widget.task.description,
        "isDone": isCompleted,
        "priority": widget.task.priority,
      });
    }
    try {
      await widget.task.save();
      if (mounted) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted && _taskCubit != null) {
            _taskCubit?.fetchAllTasks();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving task: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _handleTaskCompletion,
          icon: Icon(
            isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: isCompleted
                ? Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF4CAF50)
                    : Color(0xFF2E7D32)
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade500
                    : Colors.grey.shade400,
            size: 28,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.task.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.task.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: getPriorityColor().withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.task.priority.replaceAll(' Priority', ''),
            style: TextStyle(
              color: getPriorityColor(),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
