import 'package:flutter/material.dart';

import '../easy_loading.dart';

class FlutterEasyLoading extends StatefulWidget {
  final Widget child;

  const FlutterEasyLoading({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _FlutterEasyLoadingState createState() => _FlutterEasyLoadingState();
}

class _FlutterEasyLoadingState extends State<FlutterEasyLoading> {
  OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => EasyLoading.instance.w ?? Container(),
    );
    EasyLoading.instance.overlayEntry = _overlayEntry;
  }

  @override
  void dispose() {
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) => widget.child),
          _overlayEntry,
        ],
      ),
    );
  }
}
