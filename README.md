# Flutter EasyLoading

[![pub package](https://img.shields.io/pub/v/flutter_easyloading?style=flat)](https://pub.dev/packages/flutter_easyloading) [![pub points](https://badges.bar/flutter_easyloading/pub%20points)](https://pub.dev/packages/flutter_easyloading/score) [![popularity](https://badges.bar/flutter_easyloading/popularity)](https://pub.dev/packages/flutter_easyloading/score) [![likes](https://badges.bar/flutter_easyloading/likes)](https://pub.dev/packages/flutter_easyloading/score) [![license](https://img.shields.io/github/license/nslogx/flutter_easyloading?style=flat)](https://github.com/nslogx/flutter_easyloading) [![stars](https://img.shields.io/github/stars/nslogx/flutter_easyloading?style=social)](https://github.com/nslogx/flutter_easyloading)

English | [简体中文](./README-zh_CN.md)

<img src="https://raw.githubusercontent.com/nslogx/flutter_easyloading/master/images/gif01.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/nslogx/flutter_easyloading/master/images/gif02.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/nslogx/flutter_easyloading/master/images/gif03.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/nslogx/flutter_easyloading/master/images/gif04.gif" width=200 height=429/>

## Live Preview

👉 [https://nslogx.github.io/flutter_easyloading](https://nslogx.github.io/flutter_easyloading/#/)

## Installing

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_easyloading: ^latest
```

## Import

```dart
import 'package:flutter_easyloading/flutter_easyloading.dart';
```

## How to use

First, initialize `EasyLoading` in your `MaterialApp`/`CupertinoApp`:

```dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter EasyLoading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter EasyLoading'),
      builder: EasyLoading.init(),
    );
  }
}
```

Then, enjoy yourself:

```dart
EasyLoading.show(status: 'loading...');

EasyLoading.showProgress(0.3, status: 'downloading...');

EasyLoading.showSuccess('Great Success!');

EasyLoading.showError('Failed with Error');

EasyLoading.showInfo('Useful Information.');

EasyLoading.showToast('Toast');

EasyLoading.dismiss();
```

Add loading status callback

```dart
EasyLoading.addStatusCallback((status) {
  print('EasyLoading Status $status');
});
```

Remove loading status callback(s)

```dart
EasyLoading.removeCallback(statusCallback);

EasyLoading.removeAllCallbacks();
```

## Customize

❗️**Note:**

- **`textColor`、`indicatorColor`、`progressColor`、`backgroundColor` only used for `EasyLoadingStyle.custom`.**

- **`maskColor` only used for `EasyLoadingMaskType.custom`.**

```dart
/// loading style, default [EasyLoadingStyle.dark].
EasyLoadingStyle loadingStyle;

/// loading indicator type, default [EasyLoadingIndicatorType.fadingCircle].
EasyLoadingIndicatorType indicatorType;

/// loading mask type, default [EasyLoadingMaskType.none].
EasyLoadingMaskType maskType;

/// toast position, default [EasyLoadingToastPosition.center].
EasyLoadingToastPosition toastPosition;

/// loading animationStyle, default [EasyLoadingAnimationStyle.opacity].
EasyLoadingAnimationStyle animationStyle;

/// loading custom animation, default null.
EasyLoadingAnimation customAnimation;

/// textAlign of status, default [TextAlign.center].
TextAlign textAlign;

/// textStyle of status, default null.
TextStyle textStyle;

/// content padding of loading.
EdgeInsets contentPadding;

/// padding of [status].
EdgeInsets textPadding;

/// size of indicator, default 40.0.
double indicatorSize;

/// radius of loading, default 5.0.
double radius;

/// fontSize of loading, default 15.0.
double fontSize;

/// width of progress indicator, default 2.0.
double progressWidth;

/// width of indicator, default 4.0, only used for [EasyLoadingIndicatorType.ring, EasyLoadingIndicatorType.dualRing].
double lineWidth;

/// display duration of [showSuccess] [showError] [showInfo], default 2000ms.
Duration displayDuration;

/// animation duration of indicator, default 200ms.
Duration animationDuration;

/// color of loading status, only used for [EasyLoadingStyle.custom].
Color textColor;

/// color of loading indicator, only used for [EasyLoadingStyle.custom].
Color indicatorColor;

/// progress color of loading, only used for [EasyLoadingStyle.custom].
Color progressColor;

/// background color of loading, only used for [EasyLoadingStyle.custom].
Color backgroundColor;

/// mask color of loading, only used for [EasyLoadingMaskType.custom].
Color maskColor;

/// should allow user interactions while loading is displayed.
bool userInteractions;

/// should dismiss on user tap.
bool dismissOnTap;

/// indicator widget of loading
Widget indicatorWidget;

/// success widget of loading
Widget successWidget;

/// error widget of loading
Widget errorWidget;

/// info widget of loading
Widget infoWidget;
```

Because of `EasyLoading` is a singleton, so you can custom loading style any where like this:

```dart
EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  ..loadingStyle = EasyLoadingStyle.dark
  ..indicatorSize = 45.0
  ..radius = 10.0
  ..progressColor = Colors.yellow
  ..backgroundColor = Colors.green
  ..indicatorColor = Colors.yellow
  ..textColor = Colors.yellow
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = true
  ..dismissOnTap = false
  ..customAnimation = CustomAnimation();
```

More indicatorType can see in 👉 [flutter_spinkit showcase](https://github.com/jogboms/flutter_spinkit#-showcase)

## Custom Animation

example: 👉 [Custom Animation](https://github.com/nslogx/flutter_easyloading/blob/develop/example/lib/custom_animation.dart)

## Todo

- [x] add progress indicator

- [x] add custom animation

## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)

## ❤️❤️❤️

Thanks to [flutter_spinkit](https://github.com/jogboms/flutter_spinkit) ❤️

Supported by [JetBrains Open Source](https://www.jetbrains.com/community/opensource/#support)

[<img src="https://raw.githubusercontent.com/nslogx/flutter_easyloading/master/images/jetbrains.png" width=200 height=112/>](https://www.jetbrains.com/?from=FlutterEasyLoading)

