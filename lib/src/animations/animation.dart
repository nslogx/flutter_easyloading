import 'package:flutter/widgets.dart';

abstract class EasyLoadingAnimation {
  EasyLoadingAnimation();

  Widget call(
    Widget child,
    AnimationController controller,
  ) {
    return buildWidget(child, controller);
  }

  Widget buildWidget(
    Widget child,
    AnimationController controller,
  );
}
