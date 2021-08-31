// The MIT License (MIT)
//
// Copyright (c) 2020 nslog11
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import 'package:flutter/material.dart';

import './easy_loading.dart';
import './animations/animation.dart';
import './animations/opacity_animation.dart';
import './animations/offset_animation.dart';
import './animations/scale_animation.dart';

class EasyLoadingTheme {
  /// color of indicator
  static Color get indicatorColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.indicatorColor!
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// progress color of loading
  static Color get progressColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.progressColor!
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// background color of loading
  static Color get backgroundColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.backgroundColor!
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.black.withOpacity(0.9)
              : Colors.white;

  /// boxShadow color of loading
  static List<BoxShadow>? get boxShadow =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.boxShadow ?? [BoxShadow()]
          : null;

  /// font color of status
  static Color get textColor =>
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.textColor!
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// mask color of loading
  static Color maskColor(EasyLoadingMaskType? maskType) {
    maskType ??= EasyLoading.instance.maskType;
    return maskType == EasyLoadingMaskType.custom
        ? EasyLoading.instance.maskColor!
        : maskType == EasyLoadingMaskType.black
            ? Colors.black.withOpacity(0.5)
            : Colors.transparent;
  }

  /// loading animation
  static EasyLoadingAnimation get loadingAnimation {
    EasyLoadingAnimation _animation;
    switch (EasyLoading.instance.animationStyle) {
      case EasyLoadingAnimationStyle.custom:
        _animation = EasyLoading.instance.customAnimation!;
        break;
      case EasyLoadingAnimationStyle.offset:
        _animation = OffsetAnimation();
        break;
      case EasyLoadingAnimationStyle.scale:
        _animation = ScaleAnimation();
        break;
      default:
        _animation = OpacityAnimation();
        break;
    }
    return _animation;
  }

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

  /// toast position
  static EasyLoadingToastPosition get toastPosition =>
      EasyLoading.instance.toastPosition;

  /// toast position
  static AlignmentGeometry alignment(EasyLoadingToastPosition? position) =>
      position == EasyLoadingToastPosition.bottom
          ? AlignmentDirectional.bottomCenter
          : (position == EasyLoadingToastPosition.top
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => EasyLoading.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration =>
      EasyLoading.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => EasyLoading.instance.contentPadding;

  /// padding of status
  static EdgeInsets get textPadding => EasyLoading.instance.textPadding;

  /// textAlign of status
  static TextAlign get textAlign => EasyLoading.instance.textAlign;

  /// textStyle of status
  static TextStyle? get textStyle => EasyLoading.instance.textStyle;

  /// radius of loading
  static double get radius => EasyLoading.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => EasyLoading.instance.dismissOnTap;

  static bool ignoring(EasyLoadingMaskType? maskType) {
    maskType ??= EasyLoading.instance.maskType;
    return EasyLoading.instance.userInteractions ??
        (maskType == EasyLoadingMaskType.none ? true : false);
  }
}
