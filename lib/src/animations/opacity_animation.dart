import 'package:flutter/widgets.dart';

import 'animation.dart';

class OpacityAnimation extends EasyLoadingAnimation {
  OpacityAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    double opacity = controller?.value ?? 0;
    return Opacity(
      opacity: opacity,
      child: child,
    );
  }
}
