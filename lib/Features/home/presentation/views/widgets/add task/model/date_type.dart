
import 'package:flutter/material.dart';

enum DateType {
  start,
  end;

  String getTitle(String startDateTitle) {
        return startDateTitle;
    
  }

  Key get keyWidget {
        return const Key('start_date_input');
  }
}