# flutter_easyloading

[![pub package](https://img.shields.io/pub/v/flutter_easyloading?style=flat-square)](https://pub.dev/packages/flutter_easyloading) [![license](https://img.shields.io/github/license/huangjianke/flutter_easyloading?style=flat-square)](https://github.com/huangjianke/flutter_easyloading) [![stars](https://img.shields.io/github/stars/huangjianke/flutter_easyloading?style=social)](https://github.com/huangjianke/flutter_easyloading)

English | [简体中文](./README-zh_CN.md)

<img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif01.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif02.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif03.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif04.gif" width=200 height=429/>

## Live Preview

👉 [https://huangjianke.github.io/flutter_easyloading](https://huangjianke.github.io/flutter_easyloading/#/)

## Installing

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_easyloading: ^2.0.0
```

## Import

```dart
import 'package:flutter_easyloading/flutter_easyloading.dart';
```

## How to use

First, initialize `FlutterEasyLoading` in `MaterialApp`/`CupertinoApp`:

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
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
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

## Customize

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

/// indicator widget of loading
Widget indicatorWidget;

/// success widget of loading
Widget successWidget;

/// error widget of loading
Widget errorWidget;

/// info widget of loading
Widget infoWidget;
```

## Custom Animation

example: 👉 [Custom Animation](https://github.com/huangjianke/flutter_easyloading/blob/develop/example/lib/custom_animation.dart)

❗️**Note:**

- **`textColor`、`indicatorColor`、`progressColor`、`backgroundColor` only used for `EasyLoadingStyle.custom`.**

- **`maskColor` only used for `EasyLoadingMaskType.custom`.**


Because of `EasyLoading` is a singleton, so you can custom loading style any where like this:

```dart
EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  ..loadingStyle = EasyLoadingStyle.dark
  ..indicatorSize = 45.0
  ..radius = 10.0
  ..backgroundColor = Colors.green
  ..indicatorColor = Colors.yellow
  ..textColor = Colors.yellow
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = true;
```

More indicatorType can see in 👉 [flutter_spinkit showcase](https://github.com/jogboms/flutter_spinkit#-showcase)

## Todo

- [x] add progress indicator

- [x] add custom animation

## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)

## ❤️❤️❤️

Thanks to [flutter_spinkit](https://github.com/jogboms/flutter_spinkit) ❤️
