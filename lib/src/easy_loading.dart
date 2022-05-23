// The MIT License (MIT)
//
// Copyright (c) 2020 nslogx
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

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import './widgets/container.dart';
import './widgets/progress.dart';
import './widgets/indicator.dart';
import './widgets/overlay_entry.dart';
import './widgets/loading.dart';
import './animations/animation.dart';
import './theme.dart';

/// loading style
enum EasyLoadingStyle {
  light,
  dark,
  custom,
}

/// toast position
enum EasyLoadingToastPosition {
  top,
  center,
  bottom,
}

/// loading animation
enum EasyLoadingAnimationStyle {
  opacity,
  offset,
  scale,
  custom,
}

/// loading mask type
/// [none] default mask type, allow user interactions while loading is displayed
/// [clear] don't allow user interactions while loading is displayed
/// [black] don't allow user interactions while loading is displayed
/// [custom] while mask type is custom, maskColor should not be null
enum EasyLoadingMaskType {
  none,
  clear,
  black,
  custom,
}

/// loading indicator type. see [https://github.com/jogboms/flutter_spinkit#-showcase]
enum EasyLoadingIndicatorType {
  fadingCircle,
  circle,
  threeBounce,
  chasingDots,
  wave,
  wanderingCubes,
  rotatingPlain,
  doubleBounce,
  fadingFour,
  fadingCube,
  pulse,
  cubeGrid,
  rotatingCircle,
  foldingCube,
  pumpingHeart,
  dualRing,
  hourGlass,
  pouringHourGlass,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  squareCircle,
}

/// loading status
enum EasyLoadingStatus {
  show,
  dismiss,
}

typedef EasyLoadingStatusCallback = void Function(EasyLoadingStatus status);

class EasyLoading {
  /// loading style, default [EasyLoadingStyle.dark].
  late EasyLoadingStyle loadingStyle;

  /// loading indicator type, default [EasyLoadingIndicatorType.fadingCircle].
  late EasyLoadingIndicatorType indicatorType;

  /// loading mask type, default [EasyLoadingMaskType.none].
  late EasyLoadingMaskType maskType;

  /// toast position, default [EasyLoadingToastPosition.center].
  late EasyLoadingToastPosition toastPosition;

  /// loading animationStyle, default [EasyLoadingAnimationStyle.opacity].
  late EasyLoadingAnimationStyle animationStyle;

  /// textAlign of status, default [TextAlign.center].
  late TextAlign textAlign;

  /// content padding of loading.
  late EdgeInsets contentPadding;

  /// padding of [status].
  late EdgeInsets textPadding;

  /// size of indicator, default 40.0.
  late double indicatorSize;

  /// radius of loading, default 5.0.
  late double radius;

  /// fontSize of loading, default 15.0.
  late double fontSize;

  /// width of progress indicator, default 2.0.
  late double progressWidth;

  /// width of indicator, default 4.0, only used for [EasyLoadingIndicatorType.ring, EasyLoadingIndicatorType.dualRing].
  late double lineWidth;

  /// display duration of [showSuccess] [showError] [showInfo] [showToast], default 2000ms.
  late Duration displayDuration;

  /// animation duration of indicator, default 200ms.
  late Duration animationDuration;

  /// loading custom animation, default null.
  EasyLoadingAnimation? customAnimation;

  /// textStyle of status, default null.
  TextStyle? textStyle;

  /// color of loading status, only used for [EasyLoadingStyle.custom].
  Color? textColor;

  /// color of loading indicator, only used for [EasyLoadingStyle.custom].
  Color? indicatorColor;

  /// progress color of loading, only used for [EasyLoadingStyle.custom].
  Color? progressColor;

  /// background color of loading, only used for [EasyLoadingStyle.custom].
  Color? backgroundColor;

  /// boxShadow of loading, only used for [EasyLoadingStyle.custom].
  List<BoxShadow>? boxShadow;

  /// mask color of loading, only used for [EasyLoadingMaskType.custom].
  Color? maskColor;

  /// should allow user interactions while loading is displayed.
  bool? userInteractions;

  /// should dismiss on user tap.
  bool? dismissOnTap;

  /// indicator widget of loading
  Widget? indicatorWidget;

  /// success widget of loading
  Widget? successWidget;

  /// error widget of loading
  Widget? errorWidget;

  /// info widget of loading
  Widget? infoWidget;

  Widget? _w;

  EasyLoadingOverlayEntry? overlayEntry;
  GlobalKey<EasyLoadingContainerState>? _key;
  GlobalKey<EasyLoadingProgressState>? _progressKey;
  Timer? _timer;

  Widget? get w => _w;
  GlobalKey<EasyLoadingContainerState>? get key => _key;
  GlobalKey<EasyLoadingProgressState>? get progressKey => _progressKey;

  final List<EasyLoadingStatusCallback> _statusCallbacks =
      <EasyLoadingStatusCallback>[];

  factory EasyLoading() => _instance;
  static final EasyLoading _instance = EasyLoading._internal();

  EasyLoading._internal() {
    /// set deafult value
    loadingStyle = EasyLoadingStyle.dark;
    indicatorType = EasyLoadingIndicatorType.fadingCircle;
    maskType = EasyLoadingMaskType.none;
    toastPosition = EasyLoadingToastPosition.center;
    animationStyle = EasyLoadingAnimationStyle.opacity;
    textAlign = TextAlign.center;
    indicatorSize = 40.0;
    radius = 5.0;
    fontSize = 15.0;
    progressWidth = 2.0;
    lineWidth = 4.0;
    displayDuration = const Duration(milliseconds: 2000);
    animationDuration = const Duration(milliseconds: 200);
    textPadding = const EdgeInsets.only(bottom: 10.0);
    contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    );
  }

  static EasyLoading get instance => _instance;
  static bool get isShow => _instance.w != null;

  /// init EasyLoading
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterEasyLoading(child: child));
      } else {
        return FlutterEasyLoading(child: child);
      }
    };
  }

  /// show loading with [status] [indicator] [maskType]
  static Future<void> show({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    Widget w = indicator ?? (_instance.indicatorWidget ?? LoadingIndicator());
    return _instance._show(
      status: status,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show progress with [value] [status] [maskType], value should be 0.0 ~ 1.0.
  static Future<void> showProgress(
    double value, {
    String? status,
    EasyLoadingMaskType? maskType,
  }) async {
    assert(
      value >= 0.0 && value <= 1.0,
      'progress value should be 0.0 ~ 1.0',
    );

    if (_instance.loadingStyle == EasyLoadingStyle.custom) {
      assert(
        _instance.progressColor != null,
        'while loading style is custom, progressColor should not be null',
      );
    }

    if (_instance.w == null || _instance.progressKey == null) {
      if (_instance.key != null) await dismiss(animation: false);
      GlobalKey<EasyLoadingProgressState> _progressKey =
          GlobalKey<EasyLoadingProgressState>();
      Widget w = EasyLoadingProgress(
        key: _progressKey,
        value: value,
      );
      _instance._show(
        status: status,
        maskType: maskType,
        dismissOnTap: false,
        w: w,
      );
      _instance._progressKey = _progressKey;
    }
    // update progress
    _instance.progressKey?.currentState?.updateProgress(min(1.0, value));
    // update status
    if (status != null) _instance.key?.currentState?.updateStatus(status);
  }

  /// showSuccess [status] [duration] [maskType]
  static Future<void> showSuccess(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    Widget w = _instance.successWidget ??
        Icon(
          Icons.done,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    return _instance._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// showError [status] [duration] [maskType]
  static Future<void> showError(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    Widget w = _instance.errorWidget ??
        Icon(
          Icons.clear,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    return _instance._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// showInfo [status] [duration] [maskType]
  static Future<void> showInfo(
    String status, {
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    Widget w = _instance.infoWidget ??
        Icon(
          Icons.info_outline,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    return _instance._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// showToast [status] [duration] [toastPosition] [maskType]
  static Future<void> showToast(
    String status, {
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return _instance._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      toastPosition: toastPosition ?? EasyLoadingTheme.toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  /// dismiss loading
  static Future<void> dismiss({
    bool animation = true,
  }) {
    // cancel timer
    _instance._cancelTimer();
    return _instance._dismiss(animation);
  }

  /// add loading status callback
  static void addStatusCallback(EasyLoadingStatusCallback callback) {
    if (!_instance._statusCallbacks.contains(callback)) {
      _instance._statusCallbacks.add(callback);
    }
  }

  /// remove single loading status callback
  static void removeCallback(EasyLoadingStatusCallback callback) {
    if (_instance._statusCallbacks.contains(callback)) {
      _instance._statusCallbacks.remove(callback);
    }
  }

  /// remove all loading status callback
  static void removeAllCallbacks() {
    _instance._statusCallbacks.clear();
  }

  /// show [status] [duration] [toastPosition] [maskType]
  Future<void> _show({
    Widget? w,
    String? status,
    Duration? duration,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
    EasyLoadingToastPosition? toastPosition,
  }) async {
    assert(
      overlayEntry != null,
      'You should call EasyLoading.init() in your MaterialApp',
    );

    if (loadingStyle == EasyLoadingStyle.custom) {
      assert(
        backgroundColor != null,
        'while loading style is custom, backgroundColor should not be null',
      );
      assert(
        indicatorColor != null,
        'while loading style is custom, indicatorColor should not be null',
      );
      assert(
        textColor != null,
        'while loading style is custom, textColor should not be null',
      );
    }

    maskType ??= _instance.maskType;
    if (maskType == EasyLoadingMaskType.custom) {
      assert(
        maskColor != null,
        'while mask type is custom, maskColor should not be null',
      );
    }

    if (animationStyle == EasyLoadingAnimationStyle.custom) {
      assert(
        customAnimation != null,
        'while animationStyle is custom, customAnimation should not be null',
      );
    }

    toastPosition ??= EasyLoadingToastPosition.center;
    bool animation = _w == null;
    _progressKey = null;
    if (_key != null) await dismiss(animation: false);

    Completer<void> completer = Completer<void>();
    _key = GlobalKey<EasyLoadingContainerState>();
    _w = EasyLoadingContainer(
      key: _key,
      status: status,
      indicator: w,
      animation: animation,
      toastPosition: toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      completer: completer,
    );
    completer.future.whenComplete(() {
      _callback(EasyLoadingStatus.show);
      if (duration != null) {
        _cancelTimer();
        _timer = Timer(duration, () async {
          await dismiss();
        });
      }
    });
    _markNeedsBuild();
    return completer.future;
  }

  Future<void> _dismiss(bool animation) async {
    if (key != null && key?.currentState == null) {
      _reset();
      return;
    }

    return key?.currentState?.dismiss(animation).whenComplete(() {
      _reset();
    });
  }

  void _reset() {
    _w = null;
    _key = null;
    _progressKey = null;
    _cancelTimer();
    _markNeedsBuild();
    _callback(EasyLoadingStatus.dismiss);
  }

  void _callback(EasyLoadingStatus status) {
    for (final EasyLoadingStatusCallback callback in _statusCallbacks) {
      callback(status);
    }
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
