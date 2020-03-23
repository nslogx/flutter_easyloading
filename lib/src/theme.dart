import 'package:flutter/material.dart';

import 'easy_loading.dart';

class EasyLoadingTheme {
  /// color of indicator
  static Color get indicatorColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.indicatorColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// progress color of loading
  static Color get progressColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.progressColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// background color of loading
  static Color get backgroundColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.backgroundColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.black.withOpacity(0.9)
              : Colors.white;

  /// font color of status
  static Color get textColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.textColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// mask color of loading
  static Color get maskColor =>
      EasyLoading.instance.maskType == EasyLoadingMaskType.custom
          ? EasyLoading.instance.maskColor
          : EasyLoading.instance.maskType == EasyLoadingMaskType.black
              ? Colors.black.withOpacity(0.5)
              : Colors.transparent;

  /// font size of status
  static double get fontSize => EasyLoading.instance.fontSize;

  /// size of indicator
  static double get indicatorSize => EasyLoading.instance.indicatorSize;

  /// width of progress indicator
  static double get progressWidth => EasyLoading.instance.progressWidth;

  /// width of indicator
  static double get lineWidth => EasyLoading.instance.lineWidth;

  /// loading indicator type
  static EasyLoadingIndicatorType get indicatorType =>
      EasyLoading.instance.indicatorType;

  /// display duration
  static Duration get displayDuration => EasyLoading.instance.displayDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => EasyLoading.instance.contentPadding;

  /// padding of status
  static EdgeInsets get textPadding => EasyLoading.instance.textPadding;

  /// textAlign of status
  static TextAlign get textAlign => EasyLoading.instance.textAlign;

  /// radius of loading
  static double get radius => EasyLoading.instance.radius;

  static bool get ignoring =>
      EasyLoading.instance.userInteractions ??
      (EasyLoading.instance.maskType == EasyLoadingMaskType.none
          ? true
          : false);
}
