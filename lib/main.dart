// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/routers/Application.dart';
import 'package:flutter_app/views/list.dart';
import 'package:flutter_app/views/product.dart';
import 'package:flutter_app/views/surface.dart';
import 'package:flutter_app/views/text.dart';

final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.white,
    primaryColorLight: Colors.purple,
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.orangeAccent[400],
);

void main() {
    runApp(MyApp());
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarColor: Colors.white, // status bar color
//    ));
}

class MyApp extends StatefulWidget {
    // This widget is the root of your application.
//    @override
//    Widget build(BuildContext context) {
//        return MaterialApp(
//            title: 'Flutter Code Sample for material.AppBar.actions',
//            theme: ThemeData(
//                primarySwatch: Colors.blue,
//            ),
//            home: MyStateWidget(),
//        );
//    }

    @override
    _PageState createState() {
        return _PageState();
    }
}

class _PageState extends State<MyApp> with SingleTickerProviderStateMixin {
    String appBarTitle = tabData[0]['text'];
    TabController controller;
    static List tabData = [
        {'text': '首页', 'icon': new Icon(Icons.star)},
        {'text': '任务', 'icon': new Icon(Icons.extension)},
        {'text': '消息', 'icon': new Icon(Icons.message)},
        {'text': '我的', 'icon': new Icon(Icons.people)}
    ];
    List<Widget> myTabs = [];

    @override
    void initState() {
        super.initState();
        controller = new TabController(initialIndex: 0,
            vsync: this,
            length: tabData.length); // 这里的length 决定有多少个底导 submenus
        myTabs.forEach((w) => print(w));
        for (int i = 0; i < tabData.length; i++) {
            myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
        }
        controller.addListener(() {
            if (controller.indexIsChanging) {
                _onTabChange();
            }
        });
        Application.controller = controller;
    }

    void _onTabChange() {
        if (this.mounted) {
            this.setState(() {
                appBarTitle = tabData[controller.index]['text'];
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Code Sample for material.AppBar.actions',
            theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
//            ThemeData(
//                primaryColor: Colors.white,
//                primaryColorBrightness: Brightness.light,
//                primaryColorLight: Colors.white,
//            ),
            home: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text('$appBarTitle', textAlign: TextAlign.center)),
                body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: <Widget>[MyStateWidget(), SurfaceWidget(),
                    ShopList(products: List<Product>.generate(100, (index) =>
                        Product(name: '$index ${WordPair
                            .random()
                            .asPascalCase}')
                    )),
                    TextTest()
                    ]),
                bottomNavigationBar: Material(color: Colors.white,
                    child: SafeArea(
                        child: Container(height: 65,
                            decoration: BoxDecoration(color: const Color(0xFFF0F0F0),
                                boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: const Color(0xFFd0d0d0),
                                        blurRadius: 3.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(-1.0, -1.0),
                                    ),
                                ]),
                            child: TabBar(controller: controller,
                                isScrollable: false,
                                indicatorColor: Colors.white,
                                labelColor: Colors.blue,
                                unselectedLabelColor: const Color(0xFF8E8E8E),
                                tabs: myTabs),
                        )))
//            new TabBarView(controller: controller, children: <Widget>[
//                Surface()
//            ]),
            ));
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

}
