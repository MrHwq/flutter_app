import 'package:flutter/material.dart';
import 'package:flutter_app/views/progress_manager.dart';

void main() {
    runApp(MaterialApp(
        home: Home(),
    ));
}

class Home extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text("贝塞尔曲线")),
            body: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ProgressManager()
                ]
            ))
        );
    }
}