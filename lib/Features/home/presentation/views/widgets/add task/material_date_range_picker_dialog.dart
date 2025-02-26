
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/multiple_view_date_range_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/single_view_date_picker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/utils/responsive_utils.dart';

class MaterialDateRangePickerDialog {

  static void showDateRangePicker(
    BuildContext context,
    {
      DateTime? initStartDate,
      DateTime? initEndDate,
      double? radius,
      String confirmText = 'Set date',
      String cancelText = 'Cancel',
      String startDateTitle = 'Start date',
      String endDateTitle = 'End date',
      
      bool autoClose = true,
      SelectDateRangeActionCallback? selectDateRangeActionCallback
    }
  ) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black26,
      useRootNavigator: false,
      pageBuilder: (context, _, __) {
        return Container(
          alignment: ResponsiveUtils.isMobile(context)
            ? Alignment.bottomCenter
            : Alignment.center,
          constraints: ResponsiveUtils.isLandscapeMobile(context)
            ? const BoxConstraints(maxWidth: 450)
            : const BoxConstraints(),
          child: Material(
            borderRadius: ResponsiveUtils.isMobile(context)
              ? BorderRadius.only(
                  topLeft: Radius.circular(radius ?? 16.0),
                  topRight: Radius.circular(radius ?? 16.0))
              : BorderRadius.all(Radius.circular(radius ?? 16.0)),
            type: MaterialType.transparency,
            child: PointerInterceptor(child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: MultipleViewDateRangePicker(
                confirmText: confirmText,
                cancelText: cancelText,
                startDateTitle: startDateTitle,

                startDate: initStartDate,
                radius: radius,
                autoClose: autoClose,
                selectDateRangeActionCallback: selectDateRangeActionCallback
              ),
            )),
          ),
        );
      },
    );
  }

  static void showDatePicker(
    BuildContext context,
    {
      String? title,
      DateTime? currentDate,
      double? radius,
      bool autoClose = true,
      SelectDateActionCallback? selectDateActionCallback
    }
  ) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black26,
      useRootNavigator: false,
      pageBuilder: (context, animation, _) {
        return AnimatedBuilder(
          animation: animation,
          child: Container(
            alignment: ResponsiveUtils.isMobile(context)
              ? Alignment.bottomCenter
              : Alignment.center,
            constraints: ResponsiveUtils.isLandscapeMobile(context)
              ? const BoxConstraints(maxWidth: 450)
              : null,
            child: Material(
              borderRadius: ResponsiveUtils.isMobile(context)
                ? BorderRadius.only(
                    topLeft: Radius.circular(radius ?? 16.0),
                    topRight: Radius.circular(radius ?? 16.0))
                : BorderRadius.all(Radius.circular(radius ?? 16.0)),
              type: MaterialType.transparency,
              child: PointerInterceptor(child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: SingleViewDatePicker(
                  title: title,
                  radius: radius,
                  autoClose: autoClose,
                  currentDate: currentDate,
                  selectDateActionCallback: selectDateActionCallback
                ),
              )),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero)
                  .animate(animation),
              child: child);
          },
        );
      },
    );
  }
}