import 'package:flutter/material.dart';
import 'dart:async';

import './widgets/container.dart';
import './widgets/progress.dart';

/// loading style
enum EasyLoadingStyle {
  light,
  dark,
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

/// loading mask type
/// [none] default mask type, allow user interactions while loading is displayed
/// [clear] don't allow user interactions while loading is displayed
/// [black] don't allow user interactions while loading is displayed
enum EasyLoadingMaskType {
  none,
  clear,
  black,
  custom,
}

class EasyLoading {
  /// loading style, default [EasyLoadingStyle.dark].
  EasyLoadingStyle loadingStyle;

  /// loading indicator type, default [EasyLoadingIndicatorType.fadingCircle].
  EasyLoadingIndicatorType indicatorType;

  /// loading mask type, default [EasyLoadingMaskType.none].
  EasyLoadingMaskType maskType;

  /// textAlign of status, default [TextAlign.center].
  TextAlign textAlign;

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

  /// width of progress indicator, default 3.0.
  double progressWidth;

  /// display duration of [showSuccess] [showError] [showInfo], default 2000ms.
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

  /// success widget of loading
  Widget successWidget;

  /// error widget of loading
  Widget errorWidget;

  /// info widget of loading
  Widget infoWidget;

  BuildContext context;
  OverlayEntry _overlayEntry;
  Widget _progress;
  GlobalKey<LoadingContainerState> _key;
  GlobalKey<ProgressState> _progressKey;
  Timer _timer;

  OverlayEntry get overlayEntry => _overlayEntry;
  Widget get progress => _progress;
  GlobalKey<LoadingContainerState> get key => _key;
  GlobalKey<ProgressState> get progressKey => _progressKey;
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
    progressWidth = 3.0;
    displayDuration = const Duration(milliseconds: 2000);
    textPadding = const EdgeInsets.only(top: 10.0);
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
  static void show({
    String status,
  }) {
    _getInstance()._show(status: status);
  }

  /// show progress with [value] [status], value should be 0.0 ~ 1.0.
  static void showProgress(
    double value, {
    String status,
  }) {
    if (_getInstance().progress == null) {
      GlobalKey<ProgressState> _progressKey = GlobalKey<ProgressState>();
      Widget w = Progress(
        key: _progressKey,
        value: value,
      );
      _getInstance()._show(
        status: status,
        w: w,
      );
      _getInstance()._progressKey = _progressKey;
      _getInstance()._progress = w;
    }
    _getInstance()
        .progressKey
        .currentState
        ?.updateProgress(value >= 1 ? 1 : value);
    if (status != null) {
      _getInstance().key.currentState?.updateStatus(status);
    }
  }

  /// showSuccess [status] [duration]
  static void showSuccess(
    String status, {
    Duration duration,
  }) {
    Widget w = _getInstance().successWidget ??
        Icon(
          Icons.done,
          color: _getInstance()._indicatorColor(),
          size: _getInstance().indicatorSize,
        );
    _getInstance()._show(
      status: status,
      duration: duration ?? _getInstance().displayDuration,
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
          color: _getInstance()._indicatorColor(),
          size: _getInstance().indicatorSize,
        );
    _getInstance()._show(
      status: status,
      duration: duration ?? _getInstance().displayDuration,
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
          color: _getInstance()._indicatorColor(),
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
    // cancel timer
    _getInstance()._cancelTimer();

    if (animation) {
      final Completer<void> completer = Completer<void>();
      _getInstance().key?.currentState?.dismiss(completer);
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
    _cancelTimer();

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

    GlobalKey<LoadingContainerState> _key = GlobalKey<LoadingContainerState>();
    bool _animation = _getInstance().overlayEntry == null;
    _remove();

    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => LoadingContainer(
        key: _key,
        status: status,
        indicator: w,
        animation: _animation,
      ),
    );

    Overlay.of(_getInstance().context).insert(_overlayEntry);

    _getInstance()._overlayEntry = _overlayEntry;
    _getInstance()._key = _key;

    if (duration != null) {
      _getInstance()._timer = Timer.periodic(duration, (Timer timer) {
        dismiss();
      });
    }
  }

  void _cancelTimer() {
    _getInstance().timer?.cancel();
    _getInstance()._timer = null;
  }

  void _remove() {
    _getInstance().overlayEntry?.remove();
    _getInstance()._overlayEntry = null;
    _getInstance()._key = null;
    _getInstance()._progress = null;
    _getInstance()._progressKey = null;
  }

  Color _indicatorColor() {
    return _getInstance().loadingStyle == EasyLoadingStyle.custom
        ? _getInstance().indicatorColor
        : _getInstance().loadingStyle == EasyLoadingStyle.dark
            ? Colors.white
            : Colors.black;
  }
}
