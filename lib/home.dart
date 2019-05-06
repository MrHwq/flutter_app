import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/product.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:flutter_app/views/list.dart';
import 'package:flutter_app/views/product.dart';
import 'package:flutter_app/views/surface.dart';
import 'package:flutter_app/views/text.dart';

class HomeWidget extends StatefulWidget {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    HomeWidget({Key key}) : super(key: key);

    @override
    _PageState createState() {
        return _PageState();
    }
}

class _PageState extends State<HomeWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
    String appBarTitle = tabData[0]['text'];
    TabController _ctrl;
    static List<Map<String, Object>> tabData = [
        {'text': '首页', 'icon': Icon(Icons.star)},
        {'text': '任务', 'icon': Icon(Icons.extension)},
        {'text': '消息', 'icon': Icon(Icons.message)},
        {'text': '我的', 'icon': Icon(Icons.people)}
    ];
    List<Widget> myTabs = [];

    @override
    void initState() {
        super.initState();
        myTabs.forEach((w) => print('before, tabname: $w'));
        myTabs = tabData.map<Tab>((Map data) {
            return Tab(text: data['text'], icon: data['icon']);
        }).toList();
        myTabs.forEach((w) => print('after tabname: $w'));
        _ctrl = TabController(initialIndex: 0,
            vsync: this,
            length: tabData.length);
        _ctrl.addListener(() {
            if (_ctrl.indexIsChanging) {
                _onTabChange();
            }
        });
        Application.controller = _ctrl;
    }

    void _onTabChange() {
        if (this.mounted) {
            this.setState(() {
                appBarTitle = tabData[_ctrl.index]['text'];
            });
        }
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
        switch (state) {
            case AppLifecycleState.inactive:
                print('AppLifecycleState.inactive');
                break;
            case AppLifecycleState.paused:
                print('AppLifecycleState.paused');
                break;
            case AppLifecycleState.resumed:
                print('AppLifecycleState.resumed');
                break;
            case AppLifecycleState.suspending:
                print('AppLifecycleState.suspending');
                break;
        }

        super.didChangeAppLifecycleState(state);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('$appBarTitle', textAlign: TextAlign.center)
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _ctrl,
                children: <Widget>[MyStateWidget(), SurfaceWidget(),
                ShopList(products: List<Product>.generate(100, (index) =>
                    Product(name: '$index ${WordPair
                        .random()
                        .asPascalCase}')
                )),
                TextTest()
                ]
            ),
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
                        child: TabBar(controller: _ctrl,
                            isScrollable: false,
                            indicatorColor: Colors.white,
                            labelColor: Colors.blue,
                            unselectedLabelColor: const Color(0xFF8E8E8E),
                            tabs: myTabs),
                    )
                )
            )
        );
    }

    @override
    void dispose() {
        _ctrl.dispose();
        super.dispose();
    }

    @override
    bool get wantKeepAlive => true;
}