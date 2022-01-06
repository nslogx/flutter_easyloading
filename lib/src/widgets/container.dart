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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

import '../theme.dart';
import '../easy_loading.dart';

class EasyLoadingContainer extends StatefulWidget {
  final Widget? indicator;
  final String? status;
  final bool? dismissOnTap;
  final EasyLoadingToastPosition? toastPosition;
  final EasyLoadingMaskType? maskType;
  final Axis? axis;
  final Completer<void>? completer;
  final bool animation;

  const EasyLoadingContainer({
    Key? key,
    this.indicator,
    this.status,
    this.dismissOnTap,
    this.toastPosition,
    this.maskType,
    this.axis,
    this.completer,
    this.animation = true,
  }) : super(key: key);

  @override
  EasyLoadingContainerState createState() => EasyLoadingContainerState();
}

class EasyLoadingContainerState extends State<EasyLoadingContainer>
    with SingleTickerProviderStateMixin {
  String? _status;
  Color? _maskColor;
  late AnimationController _animationController;
  late AlignmentGeometry _alignment;
  late bool _dismissOnTap, _ignoring;
  late Axis _axis;

  bool get isPersistentCallbacks =>
      SchedulerBinding.instance?.schedulerPhase ==
      SchedulerPhase.persistentCallbacks;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _status = widget.status;
    _alignment = (widget.indicator == null && widget.status?.isNotEmpty == true)
        ? EasyLoadingTheme.alignment(widget.toastPosition)
        : AlignmentDirectional.center;
    _dismissOnTap =
        widget.dismissOnTap ?? (EasyLoadingTheme.dismissOnTap ?? false);
    _ignoring =
        _dismissOnTap ? false : EasyLoadingTheme.ignoring(widget.maskType);
    _maskColor = EasyLoadingTheme.maskColor(widget.maskType);
    _animationController = AnimationController(
      vsync: this,
      duration: EasyLoadingTheme.animationDuration,
    )..addStatusListener((status) {
        bool isCompleted = widget.completer?.isCompleted ?? false;
        if (status == AnimationStatus.completed && !isCompleted) {
          widget.completer?.complete();
        }
      });
    _axis = widget.axis ?? EasyLoadingTheme.axis;
    show(widget.animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> show(bool animation) {
    if (isPersistentCallbacks) {
      Completer<void> completer = Completer<void>();
      SchedulerBinding.instance?.addPostFrameCallback((_) => completer
          .complete(_animationController.forward(from: animation ? 0 : 1)));
      return completer.future;
    } else {
      return _animationController.forward(from: animation ? 0 : 1);
    }
  }

  Future<void> dismiss(bool animation) {
    if (isPersistentCallbacks) {
      Completer<void> completer = Completer<void>();
      SchedulerBinding.instance?.addPostFrameCallback((_) => completer
          .complete(_animationController.reverse(from: animation ? 1 : 0)));
      return completer.future;
    } else {
      return _animationController.reverse(from: animation ? 1 : 0);
    }
  }

  void updateStatus(String status) {
    if (_status == status) return;
    setState(() {
      _status = status;
    });
  }

  void _onTap() async {
    if (_dismissOnTap) await EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: _alignment,
      children: <Widget>[
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _animationController.value,
              child: IgnorePointer(
                ignoring: _ignoring,
                child: _dismissOnTap
                    ? GestureDetector(
                        onTap: _onTap,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: _maskColor,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: _maskColor,
                      ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return EasyLoadingTheme.loadingAnimation.buildWidget(
              _Indicator(
                status: _status,
                indicator: widget.indicator,
                axis: _axis,
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
  final Widget? indicator;
  final String? status;
  final Axis? axis;

  const _Indicator({
    required this.indicator,
    required this.status,
    required this.axis,
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
        boxShadow: EasyLoadingTheme.boxShadow,
      ),
      padding: EasyLoadingTheme.contentPadding,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (indicator != null && status != null) {
      return axis == Axis.vertical
          ? _buildVerticalIndicator()
          : _buildHorizontalIndicator();
    } else {
      return indicator != null ? indicator! : _buildOnlyStatus();
    }
  }

  Widget _buildOnlyStatus() {
    return Text(
      status ?? '',
      style: EasyLoadingTheme.textStyle ??
          TextStyle(
            color: EasyLoadingTheme.textColor,
            fontSize: EasyLoadingTheme.fontSize,
          ),
      textAlign: EasyLoadingTheme.textAlign,
    );
  }

  Widget _buildVerticalIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: status?.isNotEmpty == true
              ? EasyLoadingTheme.textPadding
              : EdgeInsets.zero,
          child: indicator,
        ),
        _buildOnlyStatus(),
      ],
    );
  }

  Widget _buildHorizontalIndicator() {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            alignment: ui.PlaceholderAlignment.middle,
            child: indicator!,
          ),
          WidgetSpan(
            child: SizedBox(width: EasyLoadingTheme.horizontalSpace),
          ),
          TextSpan(
            text: status,
            style: EasyLoadingTheme.textStyle ??
                TextStyle(
                  color: EasyLoadingTheme.textColor,
                  fontSize: EasyLoadingTheme.fontSize,
                ),
          ),
        ],
      ),
    );
  }
}
