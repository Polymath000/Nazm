import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:to_do/Features/home/data/cubit/task/task_cubit.dart';
import 'package:to_do/Features/home/data/task_model.dart';

class CalenderWidget extends StatelessWidget {
  final int index;
  const CalenderWidget(
      {super.key,
      required this.index,
      required this.updateDate,
      required this.today});
  final Function(DateTime) updateDate;
  final DateTime today;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCalendar(
        view: index == 1 ? CalendarView.week : CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource(context, today)),
        showNavigationArrow: true,
        showTodayButton: true,
        showWeekNumber: true,
        allowViewNavigation: true,
        onTap: (calendarTapDetails) {
          updateDate(calendarTapDetails.date!);
        },
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true),
      ),
    );
  }

  List<Meeting> _getDataSource(BuildContext context, DateTime today) {
    final cubit = context.read<TaskCubit>();
    final tasks = cubit.fetchAllTasks();

    final List<Meeting> meetings = [];
    final todayString = today.toString().split(' ')[0];

    for (TaskModel element in tasks) {
      final taskDate = element.firstDate.split(' ')[0];
      if (taskDate == todayString) {
        meetings.add(Meeting(element.title, DateTime.parse(element.firstDate)));
      }
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from);

  String eventName;
  DateTime from;
}
