import 'dart:async';
import 'package:flutter/material.dart';

import '../theme.dart';
import '../easy_loading.dart';

class EasyLoadingContainer extends StatefulWidget {
  final Widget indicator;
  final String status;
  final bool animation;
  final EasyLoadingToastPosition toastPosition;

  const EasyLoadingContainer({
    Key key,
    this.indicator,
    this.status,
    this.animation = true,
    this.toastPosition,
  }) : super(key: key);

  @override
  EasyLoadingContainerState createState() => EasyLoadingContainerState();
}

class EasyLoadingContainerState extends State<EasyLoadingContainer>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  Duration _animationDuration;
  String _status;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _status = widget.status;
    _animationDuration = widget.animation
        ? const Duration(milliseconds: 300)
        : const Duration(milliseconds: 0);

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _animationController.forward();

    if (widget.animation) {
      Future.delayed(const Duration(milliseconds: 30), () {
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
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  void dismiss(Completer completer) {
    _animationDuration = const Duration(milliseconds: 300);
    _animationController?.reverse();
    setState(() {
      _opacity = 0.0;
    });
    Future.delayed(_animationDuration, () {
      completer.complete();
    });
  }

  void updateStatus(String status) {
    if (_status == status) return;
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: EasyLoadingTheme.alignment(widget.toastPosition),
      children: <Widget>[
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _animationController?.value ?? 0,
              child: IgnorePointer(
                ignoring: EasyLoadingTheme.ignoring,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: EasyLoadingTheme.maskColor,
                ),
              ),
            );
          },
        ),
        _Indicator(
          status: _status,
          indicator: widget.indicator,
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final Widget indicator;
  final String status;

  const _Indicator({
    @required this.indicator,
    @required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          indicator != null
              ? Container(
                  margin: status?.isNotEmpty == true
                      ? EasyLoadingTheme.textPadding
                      : EdgeInsets.zero,
                  child: indicator,
                )
              : null,
          status?.isNotEmpty == true
              ? Text(
                  status,
                  style: EasyLoadingTheme.textStyle ??
                      TextStyle(
                        color: EasyLoadingTheme.textColor,
                        fontSize: EasyLoadingTheme.fontSize,
                      ),
                  textAlign: EasyLoadingTheme.textAlign,
                )
              : null,
        ].where((w) => w != null).toList(),
      ),
    );
  }
}
