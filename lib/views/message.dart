import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/message.dart';
import 'package:flutter_app/widgets/list_refresh.dart' as ListRefresh;

class MessageList extends StatefulWidget {
    MessageList({Key key}) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _MessageState();
    }
}

class _MessageState extends State<MessageList> {
    int page = 0;
    final _saveScaffoldKey = GlobalKey<ScaffoldState>();

    Widget makeCard(int idx, Object text) {
        if (text is String) {
            return Chip(label: Text(text), elevation:15, backgroundColor: Colors.blueGrey);
        } else if (text is Message) {
            return Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                elevation: 5.0,
                margin: EdgeInsets.all(10.0),
                semanticContainer: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Column( //card里面的子控件
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Container(
                            width: double.infinity,
//                            color: Colors.green,
                            child: Text('“丽江市旅游景区食品安全检查”项目将在2019年5月31日到期，请尽快处理。',
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black, fontSize: 15.0)),
                            padding: EdgeInsets.all(20),
                        ),
                        Divider(height: 1),
                        InkWell(
                            onTap: () {
                                _saveScaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('催办')));
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Container(
                                        child: Text('立即处理',
                                            style: TextStyle(
                                                color: Color(0xff666666), fontSize: 13.0)),
                                        padding: EdgeInsets.all(20)),
                                    Icon(Icons.chevron_right, color: Color(0xff666666))
                                ]))
                    ]));
        } else {
            return Text('${text.runtimeType}');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _saveScaffoldKey,
            appBar: AppBar(title: Text('催办'),
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                        Navigator.maybePop(context);
                    }
                )),
            body: ListRefresh.ListRefresh(renderItem: makeCard,
                refresh: () async {
                    print('onrefresh');
                    return Future<List<Object>>.delayed(Duration(seconds: 2), () {
                        print('onrefresh 0 end');
                        page = 0;
                        Iterable<WordPair> iter = generateWordPairs();
                        List res = [];
                        iter.take(10).forEach((WordPair wp) {
                            res.add("4月21日  17:13");
                            res.add(Message(1, wp.asPascalCase, "123123"));
                        });
                        return res;
                    });
                },
                more: () async {
                    print('onloadmore page: $page end');
                    page++;
                    return Future<List<Object>>.delayed(Duration(seconds: 4), () {
                        page++;
                        List res = [];
                        if (page < 4) {
                            Iterable<WordPair> iter = generateWordPairs();

                            iter.take(10).forEach((WordPair wp) {
                                res.add("4月21日  17:13");
                                res.add(Message(1, wp.asPascalCase, "123123"));
                            });
                        }
                        return res;
                    });
                })
        );
    }
}