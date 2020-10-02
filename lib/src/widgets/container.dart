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
  String _status;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _status = widget.status;

    _animationController = AnimationController(
      vsync: this,
      duration: EasyLoadingTheme.animationDuration,
      value: widget.animation ? 0 : 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  void dismiss(Completer completer) {
    _animationController?.reverse();
    Timer.periodic(EasyLoadingTheme.animationDuration, (Timer timer) {
      timer?.cancel();
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
    AlignmentGeometry _alignment =
        (widget.indicator == null && widget.status?.isNotEmpty == true)
            ? EasyLoadingTheme.alignment(widget.toastPosition)
            : AlignmentDirectional.center;
    return Stack(
      alignment: _alignment,
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
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return EasyLoadingTheme.loadingAnimation?.buildWidget(
              _Indicator(
                status: _status,
                indicator: widget.indicator,
              ),
              _animationController,
              _alignment,
            );
          },
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
                        decoration: TextDecoration.none,
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
