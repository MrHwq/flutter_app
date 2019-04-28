// This sample shows adding an action to an [AppBar] that opens a shopping cart.
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class _MyApp extends StatelessWidget {
// This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        List<Product> products = List<Product>.generate(100, (index) =>
            Product(name: '$index ${WordPair
                .random()
                .asPascalCase}')
        );
        return MaterialApp(
            title: 'Flutter Code Sample for material.AppBar.actions',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: ShopList(products: products),
        );
    }
}

class Product {
    const Product({this.name});

    final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShopListItem extends StatelessWidget {
    ShopListItem({Product product, this.inCart, this.onCartChanged})
        : product = product,
            super(key: ObjectKey(product));

    final Product product;
    final bool inCart;
    final CartChangedCallback onCartChanged;

    Color _getColor(BuildContext context) {
        return inCart ? Colors.black54 : Theme
            .of(context)
            .primaryColor;
    }

    TextStyle _getTextStyle(BuildContext context) {
        if (!inCart) return null;
        return TextStyle(color: Colors.black54, decoration: TextDecoration.lineThrough);
    }

    @override
    Widget build(BuildContext context) {
        return ListTile(onTap: () {
            onCartChanged(product, !inCart);
        }, leading: CircleAvatar(
            backgroundColor: _getColor(context), child: Text(product.name[0])),
            title: Text(product.name, style: _getTextStyle(context),),
        );
    }
}

class ShopList extends StatefulWidget {
    ShopList({Key key, this.products}) : super(key: key);

    final List<Product> products;

    @override
    _ShopListState createState() {
        // TODO: implement createState
        return _ShopListState();
    }

}

class _ShopListState extends State<ShopList> {
    Set<Product> _shopCart = Set<Product>();

    void _handleCart(Product product, bool inCart) {
        setState(() {
            if (inCart) {
                _shopCart.add(product);
            } else {
                _shopCart.remove(product);
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(appBar: AppBar(title: Text('购物清单'),
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.backspace),
                    onPressed: () {
                        if (Navigator.canPop(context)) {
                            Navigator.pop(context, 'wakda forever');
                        }
                    },
                ),
            ]),
            body: GridView.count(
                crossAxisCount: 2,
                children: widget.products.map((Product product) {
                    return ShopListItem(
                        product: product,
                        inCart: _shopCart.contains(product),
                        onCartChanged: _handleCart,
                    );
                }).toList(),
            ));
//              ListView(padding:   EdgeInsets.symmetric(vertical: 8),
//                children: widget.products.map((Product product) {
//                    return   ShopListItem(
//                        product: product,
//                        inCart: _shopCart.contains(product),
//                        onCartChanged: _handleCart,
//                    );
//                }).toList(),),);
    }

    @override
    void initState() {
        super.initState();
        print('initState product');
    }

    @override
    void didUpdateWidget(ShopList oldWidget) {
        super.didUpdateWidget(oldWidget);
        print('didUpdateWidget product');
    }

    @override
    void dispose() {
        super.dispose();
        print('dispose product');
    }

}