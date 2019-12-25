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
  final EasyLoadingIndicatorType _animationType =
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
      case EasyLoadingIndicatorType.fadingCircle:
        _indicator = SpinKitFadingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.circle:
        _indicator = SpinKitCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.threeBounce:
        _indicator = SpinKitThreeBounce(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.chasingDots:
        _indicator = SpinKitChasingDots(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.wave:
        _indicator = SpinKitWave(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.wanderingCubes:
        _indicator = SpinKitWanderingCubes(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.rotatingCircle:
        _indicator = SpinKitRotatingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.rotatingPlain:
        _indicator = SpinKitRotatingPlain(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.doubleBounce:
        _indicator = SpinKitDoubleBounce(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.fadingFour:
        _indicator = SpinKitFadingFour(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.fadingCube:
        _indicator = SpinKitFadingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.pulse:
        _indicator = SpinKitPulse(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.cubeGrid:
        _indicator = SpinKitCubeGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.foldingCube:
        _indicator = SpinKitFoldingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.pumpingHeart:
        _indicator = SpinKitPumpingHeart(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.dualRing:
        _indicator = SpinKitDualRing(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.hourGlass:
        _indicator = SpinKitHourGlass(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.pouringHourGlass:
        _indicator = SpinKitPouringHourglass(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.fadingGrid:
        _indicator = SpinKitFadingGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.ring:
        _indicator = SpinKitRing(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.ripple:
        _indicator = SpinKitRipple(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.spinningCircle:
        _indicator = SpinKitSpinningCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.squareCircle:
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
