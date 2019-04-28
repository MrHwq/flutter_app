import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Post.dart';
import 'package:flutter_app/models/banner_base_item.dart';
import 'package:flutter_app/views/product.dart';
import 'package:flutter_app/widgets/list_refresh.dart' as ListRefresh;
import 'package:flutter_app/widgets/pagination.dart';

//void main() => runApp(_MyApp());

//class MyApp extends StatelessWidget {
class _MyApp extends StatelessWidget {
    // This widget is the root of your application.

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Code Sample for material.AppBar.actions',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyStateWidget()
        );
    }
}

class MyStateWidget extends StatefulWidget {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen),
                child: Text('点击手势'),
            )
        );
    }
}

class _CounteState extends State<CountButton> {
    int _count = 0;

    @override
    Widget build(BuildContext context) {
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[ CountAdd(onPressed: () {
                setState(() {
                    ++_count;
                });
            },), CountDisplay(count: _count)
            ],);
    }
}

class CountDisplay extends StatelessWidget {
    CountDisplay({this.count});

    final int count;

    @override
    Widget build(BuildContext context) {
        return Text('计数器:$count');
    }
}

class CountAdd extends StatelessWidget {
    CountAdd({this.onPressed});

    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return RaisedButton(onPressed: this.onPressed,
            child: Text('增加'));
    }
}

class CountButton extends StatefulWidget {
    @override
    _CounteState createState() {
        return _CounteState();
    }
}

class RandomWordState extends State<MyStateWidget> with AutomaticKeepAliveClientMixin {
    final _suggestion = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);
    final _saved = Set<WordPair>();
    Future<Post> posts;
    String title;
    ScrollController _controller = new ScrollController(initialScrollOffset: 0,
        keepScrollOffset: true, debugLabel: "product");

    headerView() {
        return Column(
            children: <Widget>[
                Stack( //alignment: const FractionalOffset(0.9, 0.1),//方法一
                    children: <Widget>[
                        Pagination(items: List.generate(4, (idx) =>
                            BaseItem(Image.asset(
                                'assets/images/house.png', fit: BoxFit.cover), "$idx")),
                            onTap: (item) =>
                                widget._scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('点击$item')))),
//                        Positioned(
//                            //方法二
//                            top: 10.0,
//                            left: 0.0,
//                            child: this),
                    ]),
                SizedBox(
                    height: 1, child: Container(color: Theme
                    .of(context)
                    .primaryColor)),
                SizedBox(height: 10),
            ],
        );
    }

    Widget makeCard(idx, text) {
        print("asdasdasd $idx, $text");
        if (idx == 0) {
            return CountButton();
        }
        if (idx == 2) {
            return GestureButton();
        }
//        if (idx.isOdd) {
//            return Divider();
//        }
        print('text:::::${text.runtimeType},,,,$text');
        return _buildRow(context, text);
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

//    getIndexListData,
    Widget _buildSuggestions() {
        return ListRefresh.ListRefresh(makeCard, headerView, () {
            return Future.delayed(Duration(seconds: 2), () {
                Iterable<WordPair> iter = generateWordPairs();
                return iter.take(10).toList();
            });
        }, () {
            return Future.delayed(Duration(seconds: 4), () {
                Iterable<WordPair> iter = generateWordPairs();
                return iter.take(15).toList();
            });
        });
//        return ListView.builder(itemBuilder: (context, idx) {
//            if (idx == 0) {
//                return CountButton();
//            }
//            if (idx == 2) {
//                return GestureButton();
//            }
//            if (idx.isOdd) return Divider();
//            final index = idx ~/ 2;
//            if (index >= _suggestion.length) {
//                _suggestion.addAll(generateWordPairs().take(10));
//            }
//            return _buildRow(context, _suggestion[index]);
//        },
//            padding: const EdgeInsets.all(16.0),
//            addAutomaticKeepAlives: true,
//            controller: _controller,
//        );
    }

    /// context: asd
    /// pair: 单词
    Widget _buildRow(BuildContext context, WordPair pair) {
        final alreadySaved = _saved.contains(pair);
        return ListTile(title: Text(pair.asPascalCase, style: _biggerFont),
            trailing: IconButton(icon: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
                onPressed: () {
                    setState(() {
                        alreadySaved ? _saved.remove(pair) : _saved.add(pair);
                    });
                }),
            onTap: () {
                widget._scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('点击${pair.asPascalCase}')));
            },

        );
    }

    void _pushSaved(BuildContext context) {
        Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            final _saveScaffoldKey = GlobalKey<ScaffoldState>();
            final tiles = _saved.map((pair) {
                return Dismissible(key: Key(pair.asPascalCase),
                    onDismissed: (direction) {
                        _saved.remove(pair);
                        _saveScaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text("删除")));
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                        title: Text(
                            pair.asPascalCase,
                            style: _biggerFont
                        )
                    ));
            });
            final divided = ListTile.divideTiles(tiles: tiles, context: context)
                .toList();

            return Scaffold(
                key: _saveScaffoldKey,
                appBar: AppBar(title: Text('saved ')),
                body: ListView(children: divided)
            );
        }));
    }

    @override
    void initState() {
        super.initState();
        this.title = WordPair
            .random()
            .asPascalCase;
        print('title is ${title}..............');
        if (posts == null) {
            posts = fetchPost();
        }
        _controller.addListener(() {
            print('controller');
        });
    }

    @override
    Widget build(BuildContext context) {
        final wordPair = WordPair.random();
        print('build $title');
        return Scaffold(
            key: widget._scaffoldKey,
            appBar: AppBar(
                title:
//                Image.network(
//                    "https://community.particle.io/letter_avatar/positev/90/5_1017516fff9cfe3c69f855e6deabc902.png"),
                Column(
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
                        )
                    ]),
                actions: <Widget>[
                    IconButton(
                        icon: _saved.isNotEmpty ? Icon(Icons.favorite, color: Colors.red, size: 32)
                            : Icon(Icons.favorite_border, color: Colors.grey, size: 32),
                        tooltip: 'Open shopping cart ${wordPair.asPascalCase}',
                        onPressed: () {
                            _pushSaved(context);
                        },
                    ),
                ],
            )
            ,
            body:
//            _buildSuggestions(),
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
            floatingActionButton: FloatingActionButton(onPressed: () {
                _navigateShop(context);
            },
                tooltip: 'Add',
                child: Icon(Icons.add)),
//              Center(child:   Text(WordPair.random().asPascalCase))
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
            widget._scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('某人返回了：：：$result')));
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