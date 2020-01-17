# flutter_easyloading

[![pub package](https://img.shields.io/pub/v/flutter_easyloading?style=flat-square)](https://pub.dev/packages/flutter_easyloading) [![license](https://img.shields.io/github/license/huangjianke/flutter_easyloading?style=flat-square)](https://github.com/huangjianke/flutter_easyloading) [![stars](https://img.shields.io/github/stars/huangjianke/flutter_easyloading?style=social)](https://github.com/huangjianke/flutter_easyloading)

[English](./README.md) | 简体中文

<img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif01.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif02.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif03.gif" width=200 height=429/> <img src="https://raw.githubusercontent.com/huangjianke/flutter_easyloading/master/images/gif04.gif" width=200 height=429/>

## 安装

将以下代码添加到您项目中的 `pubspec.yaml` 文件:

```yaml
dependencies:
  flutter_easyloading: ^1.0.1
```

## 导入

```dart
import 'package:flutter_easyloading/flutter_easyloading.dart';
```

## 如何使用

首先, 使用 `FlutterEasyLoading` 组件包裹您的App组件:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 子组件通常为 [MaterialApp] 或者 [CupertinoApp].
    /// 这样做是为了确保 loading 组件能覆盖在其他组件之上.
    return FlutterEasyLoading(
      child: MaterialApp(
        title: 'Flutter EasyLoading',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter EasyLoading'),
      ),
    );
  }
}
```

然后, 请尽情使用吧:

```dart
EasyLoading.show(status: 'loading...');

EasyLoading.showProgress(0.3, status: 'downloading...');

EasyLoading.showSuccess('Great Success!');

EasyLoading.showError('Failed with Error');

EasyLoading.showInfo('Useful Information.');

EasyLoading.dismiss();
```

## 自定义

```dart
/// loading的样式, 默认[EasyLoadingStyle.dark].
EasyLoadingStyle loadingStyle;

/// loading的指示器类型, 默认[EasyLoadingIndicatorType.fadingCircle].
EasyLoadingIndicatorType indicatorType;

/// loading的遮罩类型, 默认[EasyLoadingMaskType.none].
EasyLoadingMaskType maskType;

/// 文本的对齐方式 , 默认[TextAlign.center].
TextAlign textAlign;

/// loading内容区域的内边距.
EdgeInsets contentPadding;

/// 文本的内边距.
EdgeInsets textPadding;

/// 指示器的大小, 默认40.0.
double indicatorSize;

/// loading的圆角大小, 默认5.0.
double radius;

/// 文本大小, 默认15.0.
double fontSize;

/// 进度条指示器的宽度, 默认2.0.
double progressWidth;

/// [showSuccess] [showError] [showInfo]的展示时间, 默认2000ms.
Duration displayDuration;

/// 文本的颜色, 仅对[EasyLoadingStyle.custom]有效.
Color textColor;

/// 指示器的颜色, 仅对[EasyLoadingStyle.custom]有效.
Color indicatorColor;

/// 进度条指示器的颜色, 仅对[EasyLoadingStyle.custom]有效.
Color progressColor;

/// loading的背景色, 仅对[EasyLoadingStyle.custom]有效.
Color backgroundColor;

/// 遮罩的背景色, 仅对[EasyLoadingMaskType.custom]有效.
Color maskColor;

/// 当loading展示的时候，是否允许用户操作.
bool userInteractions;

/// 展示成功状态的自定义组件
Widget successWidget;

/// 展示失败状态的自定义组件
Widget errorWidget;

/// 展示信息状态的自定义组件
Widget infoWidget;
```

因为 `EasyLoading` 是一个全局单例, 所以你可以在任意一个地方自定义它的样式:

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

更多的指示器类型可查看 [flutter_spinkit showcase](https://github.com/jogboms/flutter_spinkit#-showcase)

## 待完成

- [ ] 新增进度条指示器

- [ ] 新增自定义动画

## 更新日志

[CHANGELOG](./CHANGELOG.md)

## 开源许可协议

[MIT License](./LICENSE)

## ❤️❤️❤️

感谢 [flutter_spinkit](https://github.com/jogboms/flutter_spinkit) ❤️

