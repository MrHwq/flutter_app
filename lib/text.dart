// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
                    title: Text('Hello World', style: Theme
                        .of(context)
                        .primaryTextTheme
                        .title),
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.list),
                            tooltip: 'Open shopping cart ',
                            onPressed: () {},
                        ),
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

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[TextField(controller: _controller,
                onChanged: (s) {
                    print(s);
                },
                decoration: InputDecoration(hintText: 'Type sth'),),
            RaisedButton(
                onPressed: () {
                    showDialog(context: context, builder: (c) {
                        return AlertDialog(
                            title: Text('What u typed'),
                            content: Text(_controller.text),
                        );
                    });
                },
                child: Text('Done')
            )
            ]);
    }
}
