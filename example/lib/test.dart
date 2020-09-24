import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    EasyLoading.showSuccess('Use in initState');
  }

  @override
  void deactivate() {
    super.deactivate();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: FlatButton(
          textColor: Colors.blue,
          child: Text('async show'),
          onPressed: () async {
            await Future.delayed(Duration(seconds: 2));
            EasyLoading.show(status: 'loading...');
            await Future.delayed(Duration(seconds: 5));
            EasyLoading.dismiss();
          },
        ),
      ),
    );
  }
}
