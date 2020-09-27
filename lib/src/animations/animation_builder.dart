import 'package:flutter/widgets.dart';

typedef Widget OKToastAnimationBuilder(
  BuildContext context,
  Widget child,
  AnimationController controller,
  double percent,
);

abstract class BaseAnimationBuilder {
  BaseAnimationBuilder();

  Widget call(
    BuildContext context,
    Widget child,
    AnimationController controller,
    double percent,
  ) {
    return buildWidget(context, child, controller, percent);
  }

  Widget buildWidget(BuildContext context, Widget child,
      AnimationController controller, double percent);
}
