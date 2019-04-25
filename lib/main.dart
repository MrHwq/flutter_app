// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Post.dart';
import 'package:flutter_app/product.dart';

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
            home: MyStateWidget(),
        );
    }
}

class MyStateWidget extends StatefulWidget {
    MyStateWidget({Key key}) : super(key: key);

    @override
    RandomWordState createState() => RandomWordState();
}

class GestureButton extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: () {
                print('mybutton was tapped');

                final snackBar = SnackBar(content: new Text('Tap'),);
                Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Container(
                height: 36.0,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5.0),
                    color: Colors.lightGreen),
                child: Text('Engage'),
            )
        );
    }
}

class _CounteState extends State<CountButton> {
    int _count = 0;

    @override
    Widget build(BuildContext context) {
        return new Row(children: <Widget>[new CountAdd(onPressed: () {
            setState(() {
                ++_count;
            });
        },), new CountDisplay(count: _count)
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
        return new RaisedButton(onPressed: this.onPressed,
            child: Text('增加'));
    }
}

class CountButton extends StatefulWidget {
    @override
    _CounteState createState() {
        return _CounteState();
    }
}

class RandomWordState extends State<MyStateWidget> {
    final _suggestion = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);
    final _saved = Set<WordPair>();

    Widget _buildSuggestions() {
        return new ListView.builder(itemBuilder: (context, idx) {
            if (idx == 0) {
                return CountButton();
            }
            if (idx == 2) {
                return GestureButton();
            }
            if (idx.isOdd) return Divider();
            final index = idx ~/ 2;
            if (index >= _suggestion.length) {
                _suggestion.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestion[index]);
        },
            padding: const EdgeInsets.all(16.0),
        );
    }

    Widget _buildRow(WordPair pair) {
        final alreadySaved = _saved.contains(pair);
        return new ListTile(title: new Text(pair.asPascalCase, style: _biggerFont,),
            trailing: new IconButton(icon: new Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
                onPressed: () {
                    setState(() {
                        alreadySaved ? _saved.remove(pair) : _saved.add(pair);
                    });
                }),
            onTap: () {
                print('onTap');
            },

        );
    }

    void _pushSaved() {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            final tiles = _saved.map((pair) {
                return Dismissible(key: new Key(pair.asPascalCase),
                    onDismissed: (direction) {
                        _saved.remove(pair);
                        Scaffold.of(context).showSnackBar(new SnackBar(content: Text("delete")));
                    },
                    background: Container(color: Colors.red,),
                    child: ListTile(
                        title: new Text(
                            pair.asPascalCase,
                            style: _biggerFont
                        )
                    ));
            });
            final divided = ListTile.divideTiles(tiles: tiles, context: context)
                .toList();

            return new Scaffold(
                appBar: new AppBar(title: new Text('saved ')),
                body: new ListView(children: divided,)
            );
        }));
    }

    @override
    Widget build(BuildContext context) {
        final wordPair = new WordPair.random();
        return Scaffold(
            appBar: AppBar(
                title:
//                Image.network(
//                    "https://community.particle.io/letter_avatar/positev/90/5_1017516fff9cfe3c69f855e6deabc902.png"),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Image.asset(
                            'assets/images/house.png', width: 32, height: 32, fit: BoxFit.cover)
                        , Container(
                            margin: const EdgeInsets.only(top: 8),
                            child:
                            Text('Hello ${WordPair
                                .random()
                                .asPascalCase} World',
                                style: Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .title),)
                    ]),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.list),
                        tooltip: 'Open shopping cart ${wordPair.asPascalCase}',
                        onPressed: () {
                            _pushSaved();
                        },
                    ),
                ],
            )
            ,
            body:
//            _buildSuggestions(),
            new Center(child: new FutureBuilder<Post>(future: fetchPost(),
                builder: (context, snapshot) {
                    if (snapshot.hasData) {
                        return Text(snapshot.data.toString());
                    } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                })),
            floatingActionButton: new FloatingActionButton(onPressed: () {
                _navigateShop(context);
            },
                tooltip: 'Add',
                child: new Icon(Icons.add)),
//            new Center(child: new Text(WordPair.random().asPascalCase))
        );
    }

    Future<Post> fetchPost() async {
//        final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
//        final post = json.decode(response.body);
//        return Post.fromJson(post);
        return Future.delayed(Duration(seconds: 10), () {
//            return Post(userId: 1, id: 2, title: "123", body: "123123");
            throw CastError();
        });
    }

    _navigateShop(BuildContext context) async {
        final result = await Navigator.push(context, new MaterialPageRoute(builder: (context) {
            List<Product> products = new List<Product>.generate(200, (i) =>
                Product(name: WordPair
                    .random()
                    .asPascalCase)
            );
            return ShopList(products: products);
        }));
        if (result != null) {
            print(result);
//            Scaffold.of(context)
//                .showSnackBar(SnackBar(content: Text('某人返回了：：：$result')));
        }
    }
}