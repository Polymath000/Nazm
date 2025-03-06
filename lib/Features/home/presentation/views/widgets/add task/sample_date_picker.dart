import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/material_date_range_picker_dialog.dart';


Future<T?> ShowDialog<T>({required BuildContext context,
    required Function(String) onDateSelected, required DateTime? startDateSelected}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  onDateSelected(args.value.toString());
                  Navigator.pop(context);
                }
              },
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: startDateSelected,
              // Theme-aware styling
              selectionColor: isDarkMode ? Colors.tealAccent : Colors.teal,
              todayHighlightColor:
                  isDarkMode ? Colors.purpleAccent : Colors.purple,
              backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                disabledDatesTextStyle: TextStyle(
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                ),
                todayTextStyle: TextStyle(
                  color: isDarkMode ? Colors.tealAccent : Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
