import 'package:flutter/widgets.dart';

import 'animation.dart';

class ScaleAnimation extends EasyLoadingAnimation {
  ScaleAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    double opacity = controller?.value ?? 0;
    return Opacity(
      opacity: opacity,
      child: ScaleTransition(
        scale: controller,
        child: child,
      ),
    );
  }
}
