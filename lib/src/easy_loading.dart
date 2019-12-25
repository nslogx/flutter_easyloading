import 'package:flutter/material.dart';
import 'dart:async';

import './widgets/container.dart';

/// loading style
enum EasyLoadingStyle {
  light,
  dark,
  custom,
}

/// loading animation type. see [https://github.com/jogboms/flutter_spinkit#-showcase]
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

/// loading mask type
/// [none] default mask type, allow user interactions while loading is displayed
/// [clear] don't allow user interactions while loading is displayed
/// [black] don't allow user interactions while loading is displayed
enum EasyLoadingMaskType {
  none,
  clear,
  black,
}

class EasyLoading {
  /// loading style, default [EasyLoadingStyle.dark]
  EasyLoadingStyle loadingStyle;

  /// loading animation type, default [EasyLoadingIndicatorType.fadingCircle]
  EasyLoadingIndicatorType animationType;

  /// loading mask type, default [EasyLoadingMaskType.none]
  EasyLoadingMaskType maskType;

  /// textAlign of status, default [TextAlign.center].
  TextAlign textAlign;

  /// content padding of loading.
  EdgeInsets contentPadding;

  /// size of indicator, default 30.0.
  double indicatorSize;

  /// radius of loading, default 5.0.
  double radius;

  /// fontSize of loading, default 15.0.
  double fontSize;

  /// display duration of [showSuccess] [showError] [showInfo], default 2000ms
  Duration displayDuration;

  BuildContext context;
  OverlayEntry overlayEntry;
  GlobalKey<LoadingContainerState> key;
  Timer timer;

  factory EasyLoading() => _getInstance();
  static EasyLoading _instance;
  static EasyLoading get instance => _getInstance();

  EasyLoading._internal() {
    /// set deafult value
    loadingStyle = EasyLoadingStyle.dark;
    animationType = EasyLoadingIndicatorType.wave;
    maskType = EasyLoadingMaskType.none;
    textAlign = TextAlign.center;
    indicatorSize = 30.0;
    radius = 5.0;
    fontSize = 15.0;
    displayDuration = const Duration(milliseconds: 2000);
    contentPadding = const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 25.0,
    );
  }

  static EasyLoading _getInstance() {
    if (_instance == null) {
      _instance = new EasyLoading._internal();
    }
    return _instance;
  }

  /// show loading with [status]
  static void show({
    String status,
  }) {
    _getInstance()._show(status: status);
  }

  /// showSuccess [status]
  static void showSuccess(
    String status, {
    Duration duration,
  }) {
    Widget w = Icon(
      Icons.done,
      color: Colors.white,
      size: _getInstance().indicatorSize,
    );
    _getInstance()._show(
      status: status,
      duration: duration ?? _getInstance().displayDuration,
      w: w,
    );
  }

  /// showError [status]
  static void showError(
    String status, {
    Duration duration,
  }) {
    Widget w = Icon(
      Icons.clear,
      color: Colors.white,
      size: _getInstance().indicatorSize,
    );
    _getInstance()._show(
      status: status,
      duration: duration ?? _getInstance().displayDuration,
      w: w,
    );
  }

  /// showInfo [status]
  static void showInfo(
    String status, {
    Duration duration,
  }) {
    Widget w = Icon(
      Icons.info_outline,
      color: Colors.white,
      size: _getInstance().indicatorSize,
    );
    _getInstance()._show(
      status: status,
      duration: duration ?? _getInstance().displayDuration,
      w: w,
    );
  }

  /// dismiss loading
  static void dismiss({
    bool animation = true,
  }) async {
    if (animation) {
      final Completer<void> completer = Completer<void>();
      _getInstance().key.currentState?.dismiss(completer);
      completer.future.then((value) {
        _getInstance()._remove();
      });
    } else {
      _getInstance()._remove();
    }
  }

  /// show loading
  void _show({
    Widget w,
    String status,
    Duration duration,
  }) {
    _stopTimer();

    _remove();

    GlobalKey<LoadingContainerState> _key = GlobalKey<LoadingContainerState>();

    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => LoadingContainer(
        key: _key,
        status: status,
        indicator: w,
      ),
    );

    Overlay.of(_getInstance().context).insert(_overlayEntry);

    _getInstance().overlayEntry = _overlayEntry;
    _getInstance().key = _key;

    if (duration != null) {
      _getInstance().timer = Timer.periodic(duration, (Timer timer) {
        dismiss();
        _stopTimer();
      });
    }
  }

  void _stopTimer() {
    // stop timer
    _getInstance().timer?.cancel();
    _getInstance().timer = null;
  }

  void _remove() {
    _getInstance().overlayEntry?.remove();
    _getInstance().overlayEntry = null;
  }
}
