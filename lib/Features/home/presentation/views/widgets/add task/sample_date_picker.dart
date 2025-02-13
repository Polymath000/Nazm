import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/material_date_range_picker_dialog.dart';

class SampleDatePicker extends StatefulWidget {
   SampleDatePicker({Key? key, required this.onDateSelected}) : super(key: key);



  final Function(String, String) onDateSelected;

  @override
  State<SampleDatePicker> createState() => _SampleDatePickerState();
}

class _SampleDatePickerState extends State<SampleDatePicker> {
  DateTime? startDateSelected, endDateSelected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  MaterialDateRangePickerDialog.showDateRangePicker(context,
                      selectDateRangeActionCallback: (startDate, endDate) {
                    setState(() {
                      widget.onDateSelected(startDate.toString(), endDate.toString());
                      startDateSelected = startDate;
                      endDateSelected = endDate;
                    });
                  });
                }),
          ]),
    );
  }
}
