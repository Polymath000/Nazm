import 'package:flutter/material.dart';
import 'package:to_do/Features/home/data/task_model.dart';

const kPrimaryPriority = "No Priority";
const kTaskBox = 'tasks';
const testFullName = 'Abdelrahman Khaled Saad Eldin';
const testImage = 'assets/images/me.png';
const kPrimaryColor = 0xff086BFF;
const kSmallLogo = "assets/images/small.png";
const kMedLogo = "assets/images/med.png";
const kLargeLogo = "assets/images/large.png";
const List<Color> kPrimaryLoading = [
  Colors.amber,
  Colors.black,
  Colors.white,
];
List<Color> Kcolors = [
  const Color(0xff016453),
  const Color(0xff379634),
  const Color(0xff0A3200),
  const Color(0xff7B9E89),
  const Color(0xff183380),
  const Color(0xffD95D39),
  const Color(0xffF18805),
  const Color(0xffF0A202),
];

bool isOverdue(TaskModel Task) {
  DateTime taskDate = DateTime.parse(Task.firstDate);
  int dateDay = taskDate.day;
  int dateMonth = taskDate.month;
  int dateYear = taskDate.year;
  int today = DateTime.now().day;
  int todayMonth = DateTime.now().month;
  int todayYear = DateTime.now().year;
  bool re = (dateMonth < todayMonth && dateYear == todayYear) ||
      (dateMonth == todayMonth && dateDay < today && dateYear == todayYear) ||
      todayYear < dateYear;
  return re;
}
