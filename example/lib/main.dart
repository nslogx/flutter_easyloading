import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
