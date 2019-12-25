import 'package:flutter/material.dart';
import 'dart:async';

import './indicator.dart';
import '../easy_loading.dart';

class LoadingContainer extends StatefulWidget {
  final Widget indicator;
  final String status;

  LoadingContainer({
    Key key,
    this.indicator,
    this.status,
  }) : super(key: key);

  @override
  LoadingContainerState createState() => LoadingContainerState();
}

class LoadingContainerState extends State<LoadingContainer> {
  final EdgeInsets _contentPadding = EasyLoading.instance.contentPadding;
  final double _radius = EasyLoading.instance.radius;
  final double _fontSize = EasyLoading.instance.fontSize;
  final Color _color =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
          ? Colors.black.withOpacity(0.9)
          : Colors.white;
  final Color _textColor =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
          ? Colors.white
          : Colors.black;
  final EasyLoadingMaskType maskType = EasyLoading.instance.maskType;
  double _opacity = 0.0;
  Duration _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 30), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  dismiss(Completer completer) {
    setState(() {
      _opacity = 0.0;
    });
    Future.delayed(_animationDuration, () {
      completer.complete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationDuration,
      child: Stack(
        children: <Widget>[
          IgnorePointer(
            ignoring: maskType == EasyLoadingMaskType.none ? true : false,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: maskType == EasyLoadingMaskType.black
                  ? Colors.black.withOpacity(0.5)
                  : Colors.transparent,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                color: _color,
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
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.status,
                            style: TextStyle(
                              color: _textColor,
                              fontSize: _fontSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : null,
                ].where((w) => w != null).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
