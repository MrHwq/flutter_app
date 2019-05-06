// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/star_widget.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//    // This widget is the root of your application.
//    @override
//    Widget build(BuildContext context) {
//        return MaterialApp(
//            title: 'Flutter Code Sample for material.AppBar.actions',
//            theme: ThemeData(
//                primarySwatch: Colors.blue,
//            ),
//            home: Scaffold(
//                appBar: AppBar(
//                    title: Text('Hello surface World', style: Theme
//                        .of(context)
//                        .primaryTextTheme
//                        .title),
//                    actions: <Widget>[
//                        IconButton(
//                            icon: Icon(Icons.list),
//                            tooltip: 'Open shopping cart ',
//                            onPressed: () {},
//                        ),
//                    ],
//                ),
//                body: Surface(),
//            )
//        );
//    }
//}

class SurfaceWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SurfaceWidgetState();
    }
}

class _SurfaceWidgetState extends State<SurfaceWidget> {
    Column buildButtonColumn(BuildContext context, IconData icon, String label) {
        Color color = Theme
            .of(context)
            .primaryColorDark;

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
        Widget titleSection = Container(
            padding: const EdgeInsets.all(32),
            child: Row(
                children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        'title',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                ),
                                Text('Kan sub', style: TextStyle(color: Colors.grey[500]))
                            ],
                        )
                    ),
                    StarWidget()
                ],
            ));
        Widget buttonSection = Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[buildButtonColumn(context, Icons.call, 'CALL'),
                buildButtonColumn(context, Icons.near_me, 'ROUTE'),
                buildButtonColumn(context, Icons.share, 'SHARE'),
                ],
            )
        );

        final textString = '''
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:flutter/material.message';
''';
        Widget textSection = Container(
            padding: const EdgeInsets.all(32),
            child: Text(textString, softWrap: true)
        );

        Widget image = Image.asset(
            'assets/images/house.png', width: 600, height: 240, fit: BoxFit.cover);
//        return new ListView(
//            children: <Widget>[image, titleSection, buttonSection, textSection],
//        );
        return NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
                SliverAppBar(
                    primary: true,
                    snap: false,
                    brightness: Brightness.light,
                    //与floating结合使用
                    expandedHeight: 240.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(centerTitle: true,
                        title: Text("我是一个帅气的标题",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                            )), background: image,),
                ),
            ];
        },
            body: Center(
                child: ListView(
                    children: <Widget>[titleSection, buttonSection, textSection])));
    }
}
