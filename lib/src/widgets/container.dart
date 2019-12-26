import 'package:flutter/material.dart';
import 'dart:async';

import './indicator.dart';
import '../easy_loading.dart';

class LoadingContainer extends StatefulWidget {
  final Widget indicator;
  final String status;
  final bool animation;

  LoadingContainer({
    Key key,
    this.indicator,
    this.status,
    this.animation = true,
  }) : super(key: key);

  @override
  LoadingContainerState createState() => LoadingContainerState();
}

class LoadingContainerState extends State<LoadingContainer> {
  /// contentPadding of loading
  final EdgeInsets _contentPadding = EasyLoading.instance.contentPadding;

  /// radius of loading
  final double _radius = EasyLoading.instance.radius;

  /// background color of loading
  final Color _backgroundColor =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.backgroundColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.black.withOpacity(0.9)
              : Colors.white;

  /// font color of status
  final Color _textColor =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.custom
          ? EasyLoading.instance.textColor
          : EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// font size of status
  final double _fontSize = EasyLoading.instance.fontSize;

  /// padding of status
  final EdgeInsets _textPadding = EasyLoading.instance.textPadding;

  /// textAlign of status
  final TextAlign _textAlign = EasyLoading.instance.textAlign;

  /// mask color of loading
  final Color _maskColor =
      EasyLoading.instance.maskType == EasyLoadingMaskType.custom
          ? EasyLoading.instance.maskColor
          : EasyLoading.instance.maskType == EasyLoadingMaskType.black
              ? Colors.black.withOpacity(0.5)
              : Colors.transparent;

  final bool _ignoring = EasyLoading.instance.userInteractions ??
      (EasyLoading.instance.maskType == EasyLoadingMaskType.none
          ? true
          : false);

  double _opacity = 0.0;
  Duration _animationDuration;

  @override
  void initState() {
    super.initState();
    _animationDuration = widget.animation
        ? const Duration(milliseconds: 300)
        : const Duration(milliseconds: 0);
    if (widget.animation) {
      Future.delayed(const Duration(milliseconds: 30), () {
        if (!mounted) return;
        setState(() {
          _opacity = 1.0;
        });
      });
    } else {
      setState(() {
        _opacity = 1.0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  dismiss(Completer completer) {
    _animationDuration = const Duration(milliseconds: 300);
    setState(() {
      _opacity = 0.0;
    });
    Future.delayed(_animationDuration, () {
      completer.complete();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loading = Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_radius),
        ),
        padding: _contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.indicator ?? LoadingIndicator(),
            widget.status?.isNotEmpty == true
                ? Padding(
                    padding: _textPadding,
                    child: Text(
                      widget.status,
                      style: TextStyle(
                        color: _textColor,
                        fontSize: _fontSize,
                      ),
                      textAlign: _textAlign,
                    ),
                  )
                : null,
          ].where((w) => w != null).toList(),
        ),
      ),
    );

    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationDuration,
      child: Stack(
        children: <Widget>[
          IgnorePointer(
            ignoring: _ignoring,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: _maskColor,
            ),
          ),
          loading,
        ],
      ),
    );
  }
}
