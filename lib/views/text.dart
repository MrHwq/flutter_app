// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class _MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Code Sample for material.AppBar.actions',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: Scaffold(
                appBar: AppBar(
                    leading: Icon(Icons.home),
                    centerTitle: true,
                    title: Text('Hello World', style: Theme
                        .of(context)
                        .primaryTextTheme
                        .title),
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.list),
                            tooltip: 'Open shopping cart ',
                            onPressed: () {},
                        )
                    ],
                ),
                body: TextTest(),
            )
        );
    }
}

class TextTest extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _TextTestState();
    }
}

class _TextTestState extends State<TextTest> {
    final TextEditingController _controller = TextEditingController();
    bool hasText = false;

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[TextField(controller: _controller,
                onChanged: (s) {
                    print(s);
                    bool nowText = s != null && s.isNotEmpty;
                    if (nowText != hasText) {
                        setState(() {
                            hasText = nowText;
                        });
                    }
                },
                decoration: InputDecoration(hintText: '输入点东西吧')
            ),
            RaisedButton(
                onPressed: hasText ? () {
                    showDialog(context: context, builder: (c) {
                        return AlertDialog(
                            title: Text('你输入的是'),
                            content: Text(_controller.text),
                        );
                    });
                } : null,
                child: Text('完成')
            )
            ]
        );
    }
}
