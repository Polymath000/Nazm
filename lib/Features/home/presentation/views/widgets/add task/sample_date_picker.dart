import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/material_date_range_picker_dialog.dart';

class SampleDatePicker extends StatefulWidget {
  const SampleDatePicker({Key? key}) : super(key: key);

  @override
  State<SampleDatePicker> createState() => _SampleDatePickerState();
}

class _SampleDatePickerState extends State<SampleDatePicker> {
  DateTime? startDateSelected, endDateSelected;

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
                      startDateSelected = startDate;
                      endDateSelected = endDate;
                    });
                  });
                }),
          ]),
    );
  }
}


      // onPopInvokedWithResult: (didPop, result) {
      //   Dialogs.materialDialog(
      //     msg: 'Are you sure ? you can\'t undo this',
      //     title: "Delete",
      //     color: Colors.white,
      //     context: context,
      //     actions: [
      //       IconsOutlineButton(
      //         onPressed: () {},
      //         text: 'Cancel',
      //         iconData: Icons.cancel_outlined,
      //         textStyle: TextStyle(color: Colors.grey),
      //         iconColor: Colors.grey,
      //       ),
      //       IconsButton(
      //         onPressed: () {},
      //         text: 'Delete',
      //         iconData: Icons.delete,
      //         color: Colors.red,
      //         textStyle: TextStyle(color: Colors.white),
      //         iconColor: Colors.white,
      //       ),
      //     ],
      //   );
      // },
