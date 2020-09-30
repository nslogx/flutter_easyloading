import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    // EasyLoading.show();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  void loadData() async {
    try {
      EasyLoading.show();
      Response response = await Dio().get('https://github.com');
      print(response);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }
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
          child: Text('loadData'),
          onPressed: () {
            loadData();
            // await Future.delayed(Duration(seconds: 2));
            // EasyLoading.show(status: 'loading...');
            // await Future.delayed(Duration(seconds: 5));
            // EasyLoading.dismiss();
          },
        ),
      ),
    );
  }
}
