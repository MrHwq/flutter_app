import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/banner_base_item.dart';
import 'package:flutter_app/bean/post.dart';
import 'package:flutter_app/bean/product.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/views/collect.dart';
import 'package:flutter_app/views/count_button.dart';
import 'package:flutter_app/views/message.dart';
import 'package:flutter_app/views/product.dart';
import 'package:flutter_app/widgets/list_refresh.dart' as ListRefresh;
import 'package:flutter_app/widgets/pagination.dart';
import 'package:scoped_model/scoped_model.dart';

//void main() => runApp(_MyApp());

//class MyApp extends StatelessWidget {
//class _MyApp extends StatelessWidget {
//    // This widget is the root of your application.
//
//    @override
//    Widget build(BuildContext context) {
//        return MaterialApp(
//            title: 'Flutter Code Sample for material.AppBar.actions',
//            theme: ThemeData(
//                primarySwatch: Colors.blue,
//            ),
//            home: MyStateWidget()
//        );
//    }
//}

class MyStateWidget extends StatefulWidget {
//    final _scaffoldKey =  GlobalKey<ScaffoldState>();

    MyStateWidget({Key key}) : super(key: key);

    @override
    RandomWordState createState() => RandomWordState();
}

class GestureButton extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: () {
                final snackBar = SnackBar(content: Text('手势点击'),);
                Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Container(
                height: 36.0,
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
//                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen),
                child: Text('点击手势'),
            )
        );
    }
}

class RandomWordState extends State<MyStateWidget> with AutomaticKeepAliveClientMixin {
    final _suggestion = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);

//    final _saved = Set<WordPair>();
    ProductsModel words;
    Future<Post> posts;
    String title;
    ScrollController _controller = ScrollController(initialScrollOffset: 0,
        keepScrollOffset: true, debugLabel: "product");

    headerView() {
        final WordPairRandom = WordPair.random();
        return Column(
            children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Image.asset(
                            'assets/images/house.png', width: 18, height: 18, fit: BoxFit.cover),
                        Container(
                            margin: const EdgeInsets.only(top: 1),
                            child: Text(title,
                                style: Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .subtitle
                            )
                        ),
                        IconButton(
                            icon: words.products.isNotEmpty
                                ? Icon(Icons.favorite, color: Colors.red, size: 32)
                                : Icon(Icons.favorite_border, color: Colors.grey, size: 32),
                            tooltip: 'Open shopping cart ${WordPairRandom.asPascalCase}',
                            onPressed: () {
                                _pushSaved(context);
                            })
                    ]),
                Pagination(items: List.generate(4, (idx) {
                    return BaseItem(Image.asset('assets/images/banner${idx % 2}.jpg',
                        height: 200,
                        fit: BoxFit.cover), "$idx");
                }), onTap: (item) {
//                        widget._scaffoldKey.currentState.showSnackBar(
//                            SnackBar(content: Text('点击$item')))
                }),
                SizedBox(height: 10, child: Container(color: Theme
                    .of(context)
                    .primaryColorDark)),
                CountButton(),
                SizedBox(height: 30, child: Container(color: Colors.red)),
                GestureButton(),
                SizedBox(height: 30, child: Container(color: Colors.blueGrey)),
            ]
        );
    }

    Widget makeCard(idx, text) {
        return _buildRow(context, idx, text);
    }

    Future<Map> getIndexListData([Map<String, dynamic> params]) async {
        int pageIndex = (params is Map) ? params['pageIndex'] : 0;
        final _param = {'page': pageIndex, 'pageSize': 20, 'sort': 'rankIndex'};
        var pageTotal = 0;
        Iterable<WordPair> iter = generateWordPairs();
        pageIndex += 1;
        List<WordPair> resultList = iter.take(10).toList(); //.map((e) => e.asPascalCase).toList();
        Map<String, dynamic> result = {
            "list": resultList,
            'total': pageTotal,
            'pageIndex': pageIndex
        };
        return result;
    }

    int page = 0;

//    getIndexListData,
    Widget _buildSuggestions() {
        return ListRefresh.ListRefresh(
            renderItem: makeCard,
            headerView: headerView,
            refresh: () async {
                print('onrefresh');
                return Future<List<WordPair>>.delayed(Duration(seconds: 2), () {
                    setState(() {
                        words.clear();
                    });
                    print('onrefresh 0 end');
                    page = 0;
                    Iterable<WordPair> iter = generateWordPairs();
                    return iter.take(10).toList();
                });
            },
            more: () async {
                print('onloadmore page: $page end');
                page++;
                if (page < 4) {
                    return Future<List<WordPair>>.delayed(Duration(seconds: 4), () {
                        page++;
                        Iterable<WordPair> iter = generateWordPairs();
                        return iter.take(15).toList();
                    });
                } else {
                    return Future<Null>(() {
                        return null;
                    });
                }
            },
            separator: (BuildContext context, int index) => Divider(height: 1),
        );
    }

    /// context: asd
    /// pair: 单词
    Widget _buildRow(BuildContext context, int idx, WordPair pair) {
        final alreadySaved = words.products.contains(pair);
        return ListTile(
            leading: Image.asset('assets/images/house.png', fit: BoxFit.cover),
            title: Text(pair.asPascalCase, style: _biggerFont),
            subtitle: Text("通知公告"),
            trailing: IconButton(icon: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
                onPressed: () {
                    setState(() {
                        alreadySaved ? words.remove(pair) : words.add(pair);
                    });
                }),
            onTap: () {
//                widget._scaffoldKey.currentState.showSnackBar(
//                    SnackBar(content: Text('查看下一步信息${pair.asPascalCase}')));
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MessageList();
                }));
            });
    }

    void _pushSaved(BuildContext context) {
        if (words.products.isEmpty) {
//            widget._scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("没有选中单词")));
            return;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
            return CollectPage(buildContext);
        }));
    }

    @override
    void initState() {
        super.initState();
        this.title = WordPair
            .random()
            .asPascalCase;
        if (posts == null) {
            posts = fetchPost();
        }
        _controller.addListener(() {
            print('controller');
        });
    }

    @override
    Widget build(BuildContext context) {
        words = ScopedModel.of<ProductsModel>(context);
        print('build $title');
        return
//            Scaffold(
//            key: widget._scaffoldKey,
//            appBar: AppBar(title:
////                Image.network(
////                    "https://community.particle.io/letter_avatar/positev/90/5_1017516fff9cfe3c69f855e6deabc902.png"),
//            Column(
//                mainAxisSize: MainAxisSize.min,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                    Image.asset(
//                        'assets/images/house.png', width: 18, height: 18, fit: BoxFit.cover),
//                    Container(
//                        margin: const EdgeInsets.only(top: 1),
//                        child: Text(title,
//                            style: Theme
//                                .of(context)
//                                .primaryTextTheme
//                                .subtitle
//                        )
//                    )
//                ]),
//                actions: <Widget>[
//                    IconButton(
//                        icon: words.products.isNotEmpty
//                            ? Icon(Icons.favorite, color: Colors.red, size: 32)
//                            : Icon(Icons.favorite_border, color: Colors.grey, size: 32),
//                        tooltip: 'Open shopping cart ${wordPair.asPascalCase}',
//                        onPressed: () {
//                            _pushSaved(context);
//                        },
//                    ),
//                ],
//            ),
//                body:
            Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                    Container(child: FutureBuilder<Post>(future: posts,
                builder: (context, snapshot) {
                    if (snapshot.hasData) {
//                        NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
//                            return <Widget>[Text(snapshot.data.toString(),
//                                style: TextStyle(fontSize: 12,
//                                    fontWeight: FontWeight.w400,
//                                    height: 200,
//                                    color: Colors.blue))
//                            ];
//                        },
//                            body:
                        return _buildSuggestions();
                    } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                })),
                    Positioned(bottom: 16, right: 16,
                        child: FloatingActionButton(onPressed: () {
                            _navigateShop(context);
                        }, tooltip: 'Add', child: Icon(Icons.add)))
                ]
//                ),
//            floatingActionButton:
        );
    }

    Future<Post> fetchPost() async {
//        final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
//        final post = json.decode(response.body);
//        return Post.fromJson(post);
        print("we must fetch post");
        return Future.delayed(Duration(seconds: 3), () {
            print("delay have future");
            return Post(userId: 1, id: 2, title: "123", body: "123123");
//            throw CastError();
        });
    }

    _navigateShop(BuildContext context) async {
        final result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
            List<Product> products = List<Product>.generate(200, (index) =>
                Product(name: '$index ${WordPair
                    .random()
                    .asPascalCase}')
            );
            return ShopList(products: products);
        }));
        if (result != null) {
//            print(result);
//            widget._scaffoldKey.currentState
//                .showSnackBar(SnackBar(content: Text('某人返回了：：：$result')));
        }
    }

    @override
    bool get wantKeepAlive => true;

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

}