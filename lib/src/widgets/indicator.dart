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

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../easy_loading.dart';
import '../theme.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  final double _size = EasyLoadingTheme.indicatorSize;

  /// indicator color of loading
  final Color _indicatorColor = EasyLoadingTheme.indicatorColor;
  late Widget _indicator;

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
    double _width = _size;
    switch (EasyLoadingTheme.indicatorType) {
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
        _width = _size * 2;
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
          itemCount: 6,
        );
        _width = _size * 1.25;
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
          lineWidth: EasyLoadingTheme.lineWidth,
        );
        break;
      case EasyLoadingIndicatorType.hourGlass:
        _indicator = SpinKitHourGlass(
          color: _indicatorColor,
          size: _size,
        );
        break;
      case EasyLoadingIndicatorType.pouringHourGlass:
        _indicator = SpinKitPouringHourGlass(
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
          lineWidth: EasyLoadingTheme.lineWidth,
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
        _indicator = SpinKitFadingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: _width,
      ),
      child: _indicator,
    );
  }
}
