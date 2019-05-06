// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/utils/HttpUtils.dart';
import 'package:scoped_model/scoped_model.dart';

_handleGetShelf() async {
    var result = await HttpUtils.request(
        '/today',
        method: HttpUtils.GET,
        data: {
        }
    );
    print(result);
}

final ThemeData _kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
);

final ThemeData _kDefaultTheme = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.white,
    primaryColorLight: Colors.purple,
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.orangeAccent[400],
);

void main() {
//    _handleGetShelf();
    runApp(_MyApp());
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarColor: Colors.white, // status bar color
//    ));
}

class _MyApp extends StatelessWidget {
    _MyApp() {
        final router = Router();
        Routes.configureRoutes(router);
        Application.router = router;
    }

    @override
    Widget build(BuildContext context) {
        return ScopedModel<ProductsModel>(
            model: ProductsModel(),
            child: MaterialApp(
                title: 'title',
                theme: defaultTargetPlatform == TargetPlatform.iOS ? _kIOSTheme : _kDefaultTheme,
                home: HomeWidget(),
                onGenerateRoute: Application.router.generator,
            ));
    }
}
