import 'package:flutter/material.dart';
import 'package:native_add/native_add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              ListTile(
                title: Text('native_add'),
                subtitle: Text('1 + 2 = ${nativeAdd(1, 2)}'),
              ),
              ListTile(
                title: Text('native_redouble_buffer'),
                subtitle: Text('$_list x 2 = ${Redouble.ListValue(_list).toString()}'),
              ),
            ],
          )),
    );
  }
}
