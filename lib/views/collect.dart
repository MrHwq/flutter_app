import 'package:flutter/material.dart';
import 'package:flutter_app/models/products.dart';
import 'package:scoped_model/scoped_model.dart';

class CollectPage extends StatelessWidget {
    final _biggerFont = const TextStyle(fontSize: 18.0);

//    ProductsModel model;

    CollectPage(BuildContext context);

    @override
    Widget build(BuildContext context) {
        ProductsModel model = ScopedModel.of<ProductsModel>(context);

        print(model.products);
        if (model.products.isEmpty) {
            return Text("空");
        }

        final _saveScaffoldKey = GlobalKey<ScaffoldState>();
        final tiles = model.products.map<Widget>((pair) {
            return Dismissible(key: Key(pair.asPascalCase),
                onDismissed: (direction) {
                    model.remove(pair);
                    _saveScaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("删除")));
                },
                background: Container(color: Colors.red),
                child: ListTile(
                    title: Text(
                        pair.asPascalCase,
                        style: _biggerFont
                    )
                ));
        });
        print(tiles.runtimeType);
        final divided = ListTile.divideTiles(tiles: tiles, context: context)
            .toList();

        return Scaffold(
            key: _saveScaffoldKey,
            appBar: AppBar(title: Text('saved ')),
            body: ListView(children: divided)
        );
    }
}
