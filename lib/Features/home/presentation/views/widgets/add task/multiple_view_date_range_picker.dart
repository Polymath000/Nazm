import 'dart:developer';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/material_date_range_picker_dialog.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/model/date_type.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/utils/colors_utils.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/utils/image_paths.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/utils/responsive_utils.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/widgets/responsive_builder.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/widgets/text_field_builder.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/widgets/wrap_text_button.dart';

typedef SelectDateRangeActionCallback = Function(DateTime? startDate);

class MultipleViewDateRangePicker extends StatefulWidget {
  final String cancelText;
  final String confirmText;
  final String startDateTitle;
  final SelectDateRangeActionCallback? selectDateRangeActionCallback;
  final DateRangePickerController? datePickerController;
  final TextEditingController? startDateInputController;
  final DateTime? startDate;
  final List<Widget>? customDateRangeButtons;
  final double? radius;
  final double? tabletInputFieldMaxWidth;
  final bool autoClose;

  const MultipleViewDateRangePicker(
      {Key? key,
      this.confirmText = 'Set date',
      this.cancelText = 'Cancel',
      this.startDateTitle = 'Start date',
      this.startDate,
      this.selectDateRangeActionCallback,
      this.datePickerController,
      this.startDateInputController,
      this.customDateRangeButtons,
      this.radius,
      this.tabletInputFieldMaxWidth,
      this.autoClose = true})
      : super(key: key);

  @override
  State<MultipleViewDateRangePicker> createState() =>
      _MultipleViewDateRangePickerState();
}

class _MultipleViewDateRangePickerState
    extends State<MultipleViewDateRangePicker> {
  final String dateTimePattern = 'dd/MM/yyyy';
  static const _desktopDateRangePickerWidth = 650.0;
  static const _tabletDateRangePickerBottomPadding = 16.0;
  final _startDateInputTabletKey = GlobalKey();
  final _bottomViewTabletConfirmationButtonsKey = GlobalKey();
  bool _bottomViewTabletConfirmationButtonsOverflow = false;

  late DateRangePickerController _datePickerController;
  late TextEditingController _startDateInputController;

  DateTime? _startDate;
  late Debouncer _denounceStartDate;

  @override
  void initState() {
    _datePickerController =
        widget.datePickerController ?? DateRangePickerController();
    _startDateInputController =
        widget.startDateInputController ?? TextEditingController();

    _startDate = widget.startDate ?? DateTime.now();
    _initDebounceTimeForDate();
    _updateDateTextInput();
    super.initState();
    _checkIfTabletBottomButtonIsOverflowed();
  }

  void _checkIfTabletBottomButtonIsOverflowed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final startDateInputTabletRenderBox =
          _startDateInputTabletKey.currentContext?.findRenderObject()
              as RenderBox?;
      final bottomViewTabletConfirmationButtonsRenderBox =
          _bottomViewTabletConfirmationButtonsKey.currentContext
              ?.findRenderObject() as RenderBox?;

      if (startDateInputTabletRenderBox == null ||
          bottomViewTabletConfirmationButtonsRenderBox == null) return;

      final startDateInputTabletWidth =
          startDateInputTabletRenderBox.size.width;
      final bottomViewTabletConfirmationButtonsWidth =
          bottomViewTabletConfirmationButtonsRenderBox.size.width;
      if (bottomViewTabletConfirmationButtonsWidth + startDateInputTabletWidth >
          _desktopDateRangePickerWidth -
              _tabletDateRangePickerBottomPadding * 2) {
        setState(() {
          _bottomViewTabletConfirmationButtonsOverflow = true;
        });
      }
    });
  }

  void _initDebounceTimeForDate() {
    _denounceStartDate =
        Debouncer<String>(const Duration(milliseconds: 300), initialValue: '');
    _denounceStartDate.values.listen((value) => _onStartDateTextChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobile: _buildViewMobile(context), tablet: _buildViewTablet(context));
  }

  Widget _buildViewTablet(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: ResponsiveUtils.isDesktop(context)
            ? _desktopDateRangePickerWidth
            : 500,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 16)),
            boxShadow: const [
              BoxShadow(
                  color: ColorsUtils.colorShadow,
                  spreadRadius: 24,
                  blurRadius: 24,
                  offset: Offset.zero),
              BoxShadow(
                  color: ColorsUtils.colorShadowBottom,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset.zero)
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.all(8), child: _buildTopView(context)),
          const Divider(color: ColorsUtils.colorDivider, height: 1),
          Expanded(
            child: Stack(children: [
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SfDateRangePicker(
                  controller: _datePickerController,
                  onSelectionChanged: _onSelectionChanged,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.single,
                  initialDisplayDate: _startDate,
                  initialSelectedDate: _startDate,
                  enableMultiView: true,
                  enablePastDates: true,
                  viewSpacing: 16,
                  headerHeight: 48,
                  backgroundColor: Colors.white,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  showNavigationArrow: true,
                  selectionColor: ColorsUtils.colorButton,
                  selectionRadius: 6,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      dayFormat:
                          ResponsiveUtils.isDesktop(context) ? 'EEE' : 'EE',
                      firstDayOfWeek: 1,
                      viewHeaderHeight: 48,
                      viewHeaderStyle: const DateRangePickerViewHeaderStyle(
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13))),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                    todayCellDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorsUtils.colorButtonDisable),
                  ),
                  headerStyle: const DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              )),
              const Center(
                  child: VerticalDivider(
                      color: ColorsUtils.colorDivider, width: 1)),
            ]),
          ),
          const Divider(color: ColorsUtils.colorDivider, height: 1),
          _buildBottomViewTablet(context),
        ]),
      ),
    );
  }

  Widget _buildViewMobile(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.radius ?? 16),
              topRight: Radius.circular(widget.radius ?? 16),
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: ColorsUtils.colorShadow,
                  spreadRadius: 24,
                  blurRadius: 24,
                  offset: Offset.zero),
              BoxShadow(
                  color: ColorsUtils.colorShadowBottom,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset.zero)
            ]),
        child: SingleChildScrollView(
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildTopView(context),
              _buildDateInputFormMobile(context, DateType.start),
              _buildBottomViewMobile(context)
            ]),
          ),
        ));
  }

  Widget _buildTopView(BuildContext context) {
    if (widget.customDateRangeButtons != null) {
      return SizedBox(
        height: 52,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: widget.customDateRangeButtons!,
        ),
      );
    } else {
      return SizedBox(
        height: 52,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemBuilder: (context, index) {}),
      );
    }
  }

  Widget _buildDateInputFormMobile(BuildContext context, DateType dateType) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.startDateTitle,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: ColorsUtils.colorLabel),
          ),
          const SizedBox(height: 8),
          Stack(alignment: Alignment.center, children: [
            SizedBox(
              width: double.infinity,
              child: TextFieldBuilder(
                key: dateType.keyWidget,
                textController: _startDateInputController,
                onTextChange: (value) {
                  _denounceStartDate.value = value;
                  if (mounted) {
                    setState(() {});
                  }
                },
                textInputAction: TextInputAction.next,
                hintText: 'dd/mm/yyyy',
                maxWidth: double.infinity,
                keyboardType: TextInputType.number,
                inputFormatters: [DateInputFormatter()],
              ),
            ),
            Positioned(
                right: 12,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      MaterialDateRangePickerDialog.showDatePicker(context,
                          title: widget.startDateTitle,
                          selectDateActionCallback: (dateSelected) {
                        if (mounted) {
                          setState(() {
                            _startDate = dateSelected;
                            _updateDateTextInput();
                          });
                        }
                      });
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        ImagePaths.icCalendar,
                      ),
                    ),
                  ),
                ))
          ]),
        ],
      ),
    );
  }

  Widget _buildBottomViewMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: WrapTextButton(
            widget.cancelText,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            textStyle: const TextStyle(
                color: ColorsUtils.colorButton,
                fontWeight: FontWeight.w500,
                fontSize: 16),
            backgroundColor: ColorsUtils.colorButtonDisable,
            onTap: Navigator.maybeOf(context)?.maybePop,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: WrapTextButton(
            widget.confirmText,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            onTap: () {
              widget.selectDateRangeActionCallback?.call(_startDate);
              if (widget.autoClose) {
                Navigator.maybeOf(context)?.maybePop();
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildBottomViewTablet(BuildContext context) {
    if (!ResponsiveUtils.isDesktop(context)) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildDateInputFormTablet(context, DateType.start),
            ]),
            const SizedBox(height: 8),
            _buildBottomViewMobile(context)
          ],
        ),
      );
    } else if (!_bottomViewTabletConfirmationButtonsOverflow) {
      return Padding(
        padding: EdgeInsets.all(_tabletDateRangePickerBottomPadding),
        child: Row(children: [
          _startDateInputFormTablet(context),
          const Spacer(),
          _bottomViewTabletConfirmationButtons(context),
        ]),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(_tabletDateRangePickerBottomPadding),
        child: Column(
          children: [
            _startDateInputFormTablet(context),
            const SizedBox(height: 12),
            _bottomViewTabletConfirmationButtons(context),
          ],
        ),
      );
    }
  }

  Widget _buildDateInputFormTablet(BuildContext context, DateType dateType) {
    return TextFieldBuilder(
      key: dateType.keyWidget,
      textController:
          dateType == DateType.start ? _startDateInputController : null,
      onTextChange: (value) {
        _denounceStartDate.value = value;
        if (mounted) {
          setState(() {});
        }
      },
      hintText: 'dd/mm/yyyy',
      maxWidth: widget.tabletInputFieldMaxWidth,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [DateInputFormatter()],
    );
  }

  Widget _startDateInputFormTablet(BuildContext context) {
    return Row(
      key: _startDateInputTabletKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDateInputFormTablet(context, DateType.start),
        if (!_bottomViewTabletConfirmationButtonsOverflow)
          const SizedBox(width: 12),
      ],
    );
  }

  Widget _bottomViewTabletConfirmationButtons(BuildContext context) {
    return Row(
      key: _bottomViewTabletConfirmationButtonsKey,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WrapTextButton(
          widget.cancelText,
          textStyle: const TextStyle(
            color: ColorsUtils.colorButton,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          backgroundColor: ColorsUtils.colorButtonDisable,
          onTap: Navigator.maybeOf(context)?.maybePop,
        ),
        const SizedBox(width: 12),
        Flexible(
          flex: _bottomViewTabletConfirmationButtonsOverflow ? 1 : 0,
          child: WrapTextButton(
            widget.confirmText,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: () {
              widget.selectDateRangeActionCallback?.call(_startDate);
              if (widget.autoClose) {
                Navigator.maybeOf(context)?.maybePop();
              }
            },
          ),
        ),
      ],
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final selectedDate = args.value;
    log('_MultipleViewDateRangePickerState::_onSelectionChanged():selectedDate: $selectedDate');
    if (selectedDate is DateTime) {
      _startDate = selectedDate;
      _updateDateTextInput();

      if (mounted) {
        setState(() {});
      }
    }
  }

  void _onStartDateTextChanged(String value) {
    log('_MultipleViewDateRangePickerState::_onStartDateTextChanged():value: $value');
    try {
      if (value.isNotEmpty && _isDateValid(value, dateTimePattern)) {
        final startDate = DateFormat(dateTimePattern).parse(value);
        _startDate = startDate;
        _updateDatePickerSelection();
      }
    } catch (e) {
      log('_MultipleViewDateRangePickerState::_onStartDateTextChanged():Error: $e');
      _startDate = null;
      _updateDatePickerSelection();
    }
  }

  bool _isDateValid(String input, String format) {
    try {
      final DateTime dateTime = DateFormat(format).parseStrict(input);
      log('_MultipleViewDateRangePickerState::_isDateValid(): $dateTime');
      return true;
    } catch (e) {
      log('_MultipleViewDateRangePickerState::_isDateValid():Error: $e');
      return false;
    }
  }

  Future<void> _updateDatePickerSelection() async {
    _datePickerController.selectedDate = _startDate;
    _datePickerController.displayDate = _startDate;
  }

  void _updateDateTextInput() {
    if (_startDate != null) {
      final startDateString = DateFormat(dateTimePattern).format(_startDate!);
      _startDateInputController.value = TextEditingValue(
          text: startDateString,
          selection: TextSelection(
              baseOffset: startDateString.length,
              extentOffset: startDateString.length));
    } else {
      _startDateInputController.clear();
    }
  }

  @override
  void dispose() {
    _denounceStartDate.cancel();
    _startDateInputController.dispose();
    super.dispose();
  }
}
