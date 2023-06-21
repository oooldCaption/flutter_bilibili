import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/net_tool.dart';
import 'package:flutter_bilibili/http/request/test_request.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: ()async{
              var request = TestRequest();
              request.add("a", "b").add("requestPrams", 'kkkk');
              var res = await NetTool.getInstance().fire(request);
              print("--");
              print(res);


            },
          ),
        ),
      ),
    );
  }
}
