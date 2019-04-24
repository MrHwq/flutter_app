// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
import 'package:flutter_app/StarWidget.dart';

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
                    title: Text('Hello surface World', style: Theme
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
                body: Surface(),
            )
        );
    }
}

class Surface extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SurfaceState();
    }
}

class _SurfaceState extends State<Surface> {
    Column buildButtonColumn(BuildContext context, IconData icon, String label) {
        Color color = Theme
            .of(context)
            .primaryColor;

        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Icon(icon, color: color),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(label,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color))
                )
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        Widget titleSection = new Container(
            padding: const EdgeInsets.all(32),
            child: Row(
                children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: new Text(
                                        'title',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                ),
                                Text('Kan sub', style: TextStyle(color: Colors.grey[500]))
                            ],
                        )),
                    StarWidget()
                ],
            ));
        Widget buttonSection = new Container(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[buildButtonColumn(context, Icons.call, 'CALL'),
                buildButtonColumn(context, Icons.near_me, 'ROUTE'),
                buildButtonColumn(context, Icons.share, 'SHARE'),
                ],
            )
        );

        final textString = '''
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
''';
        Widget textSection = new Container(
            padding: const EdgeInsets.all(32),
            child: new Text(textString, softWrap: true)
        );

        Widget image = Image.asset(
            'assets/images/house.png', width: 600, height: 240, fit: BoxFit.cover);
        return new ListView(
            children: <Widget>[image, titleSection, buttonSection, textSection],
        );
    }
}
