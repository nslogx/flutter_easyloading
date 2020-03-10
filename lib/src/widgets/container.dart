import 'package:flutter/material.dart';
import 'dart:async';

import '../theme.dart';

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
  double _opacity = 0.0;
  Duration _animationDuration;
  String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.status;
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

  void dismiss(Completer completer) {
    _animationDuration = const Duration(milliseconds: 300);
    setState(() {
      _opacity = 0.0;
    });
    Future.delayed(_animationDuration, () {
      completer.complete();
    });
  }

  void updateStatus(String status) {
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loading = Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: EasyLoadingTheme.backgroundColor,
          borderRadius: BorderRadius.circular(
            EasyLoadingTheme.radius,
          ),
        ),
        padding: EasyLoadingTheme.contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.indicator != null
                ? Container(
                    margin: _status?.isNotEmpty == true
                        ? EasyLoadingTheme.textPadding
                        : EdgeInsets.zero,
                    child: widget.indicator,
                  )
                : null,
            _status?.isNotEmpty == true
                ? Text(
                    _status,
                    style: TextStyle(
                      color: EasyLoadingTheme.textColor,
                      fontSize: EasyLoadingTheme.fontSize,
                    ),
                    textAlign: EasyLoadingTheme.textAlign,
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
            ignoring: EasyLoadingTheme.ignoring,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: EasyLoadingTheme.maskColor,
            ),
          ),
          loading,
        ],
      ),
    );
  }
}
