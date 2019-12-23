import 'package:flutter/material.dart';
import '../easy_loading.dart';

class FlutterEasyLoading extends StatefulWidget {
  /// should be [MaterialApp] or [CupertinoApp].
  final Widget child;

  const FlutterEasyLoading({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _FlutterEasyLoadingState createState() => _FlutterEasyLoadingState();
}

class _FlutterEasyLoadingState extends State<FlutterEasyLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext _context) {
              EasyLoading.instance.context = _context;
              return widget.child;
            },
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
