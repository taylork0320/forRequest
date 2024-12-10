import 'dart:ui';

import '../styles/color_styles.dart';

enum ExperimentType {
  survey("설문형", ColorStyles.primaryOrange, ColorStyles.secondaryOrange), // 설문형
  perform("수행형", ColorStyles.primaryBlue, ColorStyles.secondaryBlue); // 수행형

  final String title;
  final Color tagForegroundColor;
  final Color tagBackgroundColor;

  const ExperimentType(this.title, this.tagForegroundColor, this.tagBackgroundColor);
}