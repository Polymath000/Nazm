import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWidget extends StatelessWidget {
  final int index;
  const CalenderWidget(
      {super.key, required this.index, required this.updateDate});
  final Function(DateTime) updateDate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCalendar(
        view: index == 1 ? CalendarView.week : CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
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

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[
      Meeting(
        "task",
        DateTime(2024, 11, 15),
      )
    ];

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
