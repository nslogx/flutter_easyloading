import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../easy_loading.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  final double _size = EasyLoading.instance.indicatorSize;
  final EasyLoadingAnimationType _animationType =
      EasyLoading.instance.animationType;
  final Color _indicatorColor =
      EasyLoading.instance.loadingStyle == EasyLoadingStyle.dark
          ? Colors.white
          : Colors.black;

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
    Widget _indicator;
    switch (_animationType) {
      case EasyLoadingAnimationType.fadingCircle:
        _indicator = SpinKitFadingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.circle:
        _indicator = SpinKitCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.threeBounce:
        _indicator = SpinKitThreeBounce(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.chasingDots:
        _indicator = SpinKitChasingDots(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.wave:
        _indicator = SpinKitWave(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.wanderingCubes:
        _indicator = SpinKitWanderingCubes(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.rotatingCircle:
        _indicator = SpinKitRotatingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.rotatingPlain:
        _indicator = SpinKitRotatingPlain(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.doubleBounce:
        _indicator = SpinKitDoubleBounce(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.fadingFour:
        _indicator = SpinKitFadingFour(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.fadingCube:
        _indicator = SpinKitFadingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.pulse:
        _indicator = SpinKitPulse(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.cubeGrid:
        _indicator = SpinKitCubeGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.foldingCube:
        _indicator = SpinKitFoldingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.pumpingHeart:
        _indicator = SpinKitPumpingHeart(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.dualRing:
        _indicator = SpinKitDualRing(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.hourGlass:
        _indicator = SpinKitHourGlass(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.pouringHourGlass:
        _indicator = SpinKitPouringHourglass(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.fadingGrid:
        _indicator = SpinKitFadingGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.ring:
        _indicator = SpinKitRing(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.ripple:
        _indicator = SpinKitRipple(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.spinningCircle:
        _indicator = SpinKitSpinningCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingAnimationType.squareCircle:
        _indicator = SpinKitSquareCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      default:
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: _size * 2,
      ),
      child: _indicator,
    );
  }
}
