import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/material_date_range_picker_dialog.dart';

class SampleDatePicker extends StatefulWidget {
  const SampleDatePicker({Key? key, required this.onDateSelected})
      : super(key: key);

  final Function(String) onDateSelected;

  @override
  State<SampleDatePicker> createState() => _SampleDatePickerState();
}

class _SampleDatePickerState extends State<SampleDatePicker> {
  DateTime? startDateSelected;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SfDateRangePicker(
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            if (args.value is DateTime) {
                              widget.onDateSelected(args.value.toString());
                              Navigator.pop(context);
                            }
                          },
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedDate: startDateSelected,
                          // Theme-aware styling
                          selectionColor:
                              isDarkMode ? Colors.tealAccent : Colors.teal,
                          todayHighlightColor:
                              isDarkMode ? Colors.purpleAccent : Colors.purple,
                          backgroundColor:
                              isDarkMode ? Colors.grey[900] : Colors.white,
                          monthCellStyle: DateRangePickerMonthCellStyle(
                            textStyle: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                            disabledDatesTextStyle: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                            todayTextStyle: TextStyle(
                              color:
                                  isDarkMode ? Colors.tealAccent : Colors.teal,
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
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
