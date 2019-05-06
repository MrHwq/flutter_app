import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';

// app的首页
var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return HomeWidget();
    },
);

var categoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String name = params["type"]?.first;

//        return new CategoryHome(name);
    },
);

var widgetNotFoundHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//        return new WidgetNotFound();
    });

var fullScreenCodeDialog = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String path = params['filePath']?.first;
//        return new FullScreenCodeDialog(
//            filePath: path,
//        );
    });

var webViewPageHand = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String title = params['title']?.first;
        String url = params['url']?.first;
//        return new WebViewPage(url, title);
    });
