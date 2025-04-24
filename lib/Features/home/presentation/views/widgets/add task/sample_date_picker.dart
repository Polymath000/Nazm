import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<void> ShowDialog({
  required BuildContext context,
  required Function(String) onDateSelected,
  DateTime? startDateSelected,
}) async {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          showNavigationArrow: true,
          showActionButtons: true,
          allowViewNavigation: true,
          cancelText: "Cancel",
          onCancel: () {
            Navigator.pop(context);
          },
          onSubmit: (p0) {
            if (p0 is DateTime) {
              String YMD = p0.toString().split(' ')[0];
              String HMS = DateTime.now().toString().split(' ')[1];
              p0 = '$YMD $HMS';

              onDateSelected(p0.toString());
              print("Selected date: $p0");

              Navigator.pop(context);
            }
          },
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {},
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedDate: startDateSelected,
          selectionColor: isDarkMode ? Colors.tealAccent : Colors.teal,
          todayHighlightColor: isDarkMode ? Colors.purpleAccent : Colors.purple,
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            todayTextStyle: TextStyle(
              color: isDarkMode ? Colors.tealAccent : Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
