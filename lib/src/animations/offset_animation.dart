import 'package:flutter/widgets.dart';

import 'animation.dart';

class OffsetAnimation extends EasyLoadingAnimation {
  OffsetAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    Offset _begin = alignment == AlignmentDirectional.topCenter
        ? Offset(0, -1)
        : alignment == AlignmentDirectional.bottomCenter
            ? Offset(0, 1)
            : Offset(0, 0);
    Animation<Offset> _animation = Tween(
      begin: _begin,
      end: Offset(0, 0),
    ).animate(controller);
    double value = controller?.value ?? 0;
    return Opacity(
      opacity: value,
      child: SlideTransition(
        position: _animation,
        child: child,
      ),
    );
  }
}
