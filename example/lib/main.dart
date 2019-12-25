import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter EasyLoading'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('dismiss'),
                    onPressed: () {
                      EasyLoading.dismiss();
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('show'),
                    onPressed: () {
                      EasyLoading.show(status: 'loading...');
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('showSuccess'),
                    onPressed: () {
                      EasyLoading.showSuccess('Great Success!');
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('showError'),
                    onPressed: () {
                      EasyLoading.showError('Failed with Error');
                    },
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text('showInfo'),
                    onPressed: () {
                      EasyLoading.showInfo('Useful Information.');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Style'),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: CupertinoSegmentedControl<EasyLoadingStyle>(
                          selectedColor: Colors.blue,
                          children: {
                            EasyLoadingStyle.dark: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("dark"),
                            ),
                            EasyLoadingStyle.light: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("light"),
                            ),
                          },
                          onValueChanged: (value) {
                            EasyLoading.instance.loadingStyle = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('MaskType'),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: CupertinoSegmentedControl<EasyLoadingMaskType>(
                          selectedColor: Colors.blue,
                          children: {
                            EasyLoadingMaskType.none: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("none"),
                            ),
                            EasyLoadingMaskType.clear: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("clear"),
                            ),
                            EasyLoadingMaskType.black: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("black"),
                            ),
                          },
                          onValueChanged: (value) {
                            EasyLoading.instance.maskType = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('IndicatorType'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingIndicatorType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingIndicatorType.wave: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("wave"),
                          ),
                          EasyLoadingIndicatorType.fadingCircle: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("fadingCircle"),
                          ),
                          EasyLoadingIndicatorType.cubeGrid: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("cubeGrid"),
                          ),
                          EasyLoadingIndicatorType.pulse: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("pulse"),
                          ),
                          EasyLoadingIndicatorType.threeBounce: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("threeBounce"),
                          ),
                          EasyLoadingIndicatorType.circle: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("circle"),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.indicatorType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
