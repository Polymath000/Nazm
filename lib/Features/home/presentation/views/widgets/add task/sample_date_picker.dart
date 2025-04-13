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
      content: Container(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            if (args.value is DateTime) {
              print("Selected date: ${args.value}");
              onDateSelected(args.value.toString());
              Navigator.pop(context);
            }
          },
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
