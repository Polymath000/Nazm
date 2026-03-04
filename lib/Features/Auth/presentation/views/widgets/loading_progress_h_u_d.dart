import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:to_do/constants.dart';

class LoadingProgressHUD extends StatefulWidget {
  const LoadingProgressHUD(
      {super.key, required this.isLoading, required this.child});
  final Widget child;

  final bool isLoading;

  @override
  State<LoadingProgressHUD> createState() => _LoadingProgressHUDState();
}

class _LoadingProgressHUDState extends State<LoadingProgressHUD> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 0.6,
      dismissible: false,
      inAsyncCall: widget.isLoading,
      progressIndicator: SizedBox(
        width: MediaQuery.sizeOf(context).width / 1.6,
        child: const LoadingIndicator(
          indicatorType: Indicator.pacman,
          colors: kPrimaryLoading,
        ),
      ),
      child: widget.child,
    );
  }
}
