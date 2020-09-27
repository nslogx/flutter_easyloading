import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import './widgets/container.dart';
import './widgets/progress.dart';
import './widgets/indicator.dart';
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

class EasyLoading {
  /// loading style, default [EasyLoadingStyle.dark].
  EasyLoadingStyle loadingStyle;

  /// loading indicator type, default [EasyLoadingIndicatorType.fadingCircle].
  EasyLoadingIndicatorType indicatorType;

  /// loading mask type, default [EasyLoadingMaskType.none].
  EasyLoadingMaskType maskType;

  /// toast position, default [EasyLoadingToastPosition.center].
  EasyLoadingToastPosition toastPosition;

  /// textAlign of status, default [TextAlign.center].
  TextAlign textAlign;

  /// textStyle of status, default null.
  TextStyle textStyle;

  /// content padding of loading.
  EdgeInsets contentPadding;

  /// padding of [status].
  EdgeInsets textPadding;

  /// size of indicator, default 40.0.
  double indicatorSize;

  /// radius of loading, default 5.0.
  double radius;

  /// fontSize of loading, default 15.0.
  double fontSize;

  /// width of progress indicator, default 2.0.
  double progressWidth;

  /// width of indicator, default 4.0, only used for [EasyLoadingIndicatorType.ring, EasyLoadingIndicatorType.dualRing].
  double lineWidth;

  /// display duration of [showSuccess] [showError] [showInfo] [showToast], default 2000ms.
  Duration displayDuration;

  /// color of loading status, only used for [EasyLoadingStyle.custom].
  Color textColor;

  /// color of loading indicator, only used for [EasyLoadingStyle.custom].
  Color indicatorColor;

  /// progress color of loading, only used for [EasyLoadingStyle.custom].
  Color progressColor;

  /// background color of loading, only used for [EasyLoadingStyle.custom].
  Color backgroundColor;

  /// mask color of loading, only used for [EasyLoadingMaskType.custom].
  Color maskColor;

  /// should allow user interactions while loading is displayed.
  bool userInteractions;

  /// indicator widget of loading
  Widget indicatorWidget;

  /// success widget of loading
  Widget successWidget;

  /// error widget of loading
  Widget errorWidget;

  /// info widget of loading
  Widget infoWidget;

  OverlayEntry overlayEntry;
  Widget _w;

  GlobalKey<EasyLoadingContainerState> _key;
  GlobalKey<EasyLoadingProgressState> _progressKey;
  Timer _timer;

  Widget get w => _w;
  GlobalKey<EasyLoadingContainerState> get key => _key;
  GlobalKey<EasyLoadingProgressState> get progressKey => _progressKey;
  Timer get timer => _timer;

  factory EasyLoading() => _getInstance();
  static EasyLoading _instance;
  static EasyLoading get instance => _getInstance();

  EasyLoading._internal() {
    /// set deafult value
    loadingStyle = EasyLoadingStyle.dark;
    indicatorType = EasyLoadingIndicatorType.fadingCircle;
    maskType = EasyLoadingMaskType.none;
    textAlign = TextAlign.center;
    indicatorSize = 40.0;
    radius = 5.0;
    fontSize = 15.0;
    progressWidth = 2.0;
    lineWidth = 4.0;
    displayDuration = const Duration(milliseconds: 2000);
    textPadding = const EdgeInsets.only(bottom: 10.0);
    contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    );
  }

  static EasyLoading _getInstance() {
    if (_instance == null) {
      _instance = EasyLoading._internal();
    }
    return _instance;
  }

  /// show loading with [status]
  /// [indicator] custom indicator
  static void show({
    String status,
    Widget indicator,
  }) {
    Widget w =
        indicator ?? (_getInstance().indicatorWidget ?? LoadingIndicator());
    _getInstance()._show(
      status: status,
      w: w,
    );
  }

  /// show progress with [value] [status], value should be 0.0 ~ 1.0.
  static void showProgress(
    double value, {
    String status,
  }) {
    assert(
      value >= 0.0 && value <= 1.0,
      'progress value should be 0.0 ~ 1.0',
    );
    if (_getInstance()._progressKey == null || _getInstance().w == null) {
      GlobalKey<EasyLoadingProgressState> _progressKey =
          GlobalKey<EasyLoadingProgressState>();
      Widget w = EasyLoadingProgress(
        key: _progressKey,
        value: value,
      );
      _getInstance()._show(
        status: status,
        w: w,
      );
      _getInstance()._progressKey = _progressKey;
    }
    _getInstance()
        .progressKey
        ?.currentState
        ?.updateProgress(value >= 1.0 ? 1.0 : value);
    if (status != null) _getInstance().key?.currentState?.updateStatus(status);
  }

  /// showSuccess [status] [duration]
  static void showSuccess(
    String status, {
    Duration duration,
  }) {
    Widget w = _getInstance().successWidget ??
        Icon(
          Icons.done,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    _getInstance()._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      w: w,
    );
  }

  /// showError [status] [duration]
  static void showError(
    String status, {
    Duration duration,
  }) {
    Widget w = _getInstance().errorWidget ??
        Icon(
          Icons.clear,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    _getInstance()._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      w: w,
    );
  }

  /// showInfo [status] [duration]
  static void showInfo(
    String status, {
    Duration duration,
  }) {
    Widget w = _getInstance().infoWidget ??
        Icon(
          Icons.info_outline,
          color: EasyLoadingTheme.indicatorColor,
          size: EasyLoadingTheme.indicatorSize,
        );
    _getInstance()._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      w: w,
    );
  }

  /// showToast [status] [duration]
  static void showToast(
    String status, {
    Duration duration,
    EasyLoadingToastPosition toastPosition,
  }) {
    _getInstance()._show(
      status: status,
      duration: duration ?? EasyLoadingTheme.displayDuration,
      toastPosition: toastPosition ?? EasyLoadingTheme.toastPosition,
    );
  }

  /// dismiss loading
  static void dismiss({
    bool animation = true,
  }) async {
    // cancel timer
    _getInstance()._cancelTimer();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _getInstance()._dismiss(animation);
      });
    } else {
      _getInstance()._dismiss(animation);
    }
  }

  /// show loading
  void _show({
    Widget w,
    String status,
    Duration duration,
    EasyLoadingToastPosition toastPosition = EasyLoadingToastPosition.center,
  }) {
    assert(
      _getInstance().overlayEntry != null,
      'overlayEntry should not be null',
    );

    assert(
      toastPosition != null,
      'toastPosition should not be null',
    );

    if (_getInstance().loadingStyle == EasyLoadingStyle.custom) {
      assert(
        _getInstance().backgroundColor != null,
        'while loading style is custom, backgroundColor should not be null',
      );
      assert(
        _getInstance().indicatorColor != null,
        'while loading style is custom, indicatorColor should not be null',
      );
      assert(
        _getInstance().progressColor != null,
        'while loading style is custom, progressColor should not be null',
      );
      assert(
        _getInstance().textColor != null,
        'while loading style is custom, textColor should not be null',
      );
    }

    if (_getInstance().maskType == EasyLoadingMaskType.custom) {
      assert(
        _getInstance().maskColor != null,
        'while mask type is custom, maskColor should not be null',
      );
    }

    _cancelTimer();
    _getInstance()._progressKey = null;

    GlobalKey<EasyLoadingContainerState> _key =
        GlobalKey<EasyLoadingContainerState>();
    _getInstance()._w = EasyLoadingContainer(
      key: _key,
      status: status,
      indicator: w,
      animation: _getInstance()._w == null,
      toastPosition: toastPosition,
    );
    _markNeedsBuild();
    _getInstance()._key = _key;
    if (duration != null) {
      _getInstance()._timer = Timer.periodic(duration, (Timer timer) {
        dismiss();
      });
    }
  }

  void _dismiss(bool animation) {
    if (animation) {
      EasyLoadingContainerState easyLoadingContainerState =
          _getInstance().key?.currentState;
      if (easyLoadingContainerState != null) {
        final Completer<void> completer = Completer<void>();
        easyLoadingContainerState.dismiss(completer);
        completer.future.then((value) {
          _reset();
        });
        return;
      }
    }
    _reset();
  }

  void _reset() {
    _getInstance()._w = null;
    _getInstance()._key = null;
    _getInstance()._progressKey = null;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _getInstance().overlayEntry?.markNeedsBuild();
      });
    } else {
      _getInstance().overlayEntry?.markNeedsBuild();
    }
  }

  void _cancelTimer() {
    _getInstance().timer?.cancel();
    _getInstance()._timer = null;
  }
}
