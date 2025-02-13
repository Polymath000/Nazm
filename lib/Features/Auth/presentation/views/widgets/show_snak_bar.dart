// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

ShowSnakBar(BuildContext context, String errorMessage) {
  showTopSnackBar(
      Overlay.of(context), CustomSnackBar.info(message: errorMessage));
}
