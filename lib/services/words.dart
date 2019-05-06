import 'dart:async';

class WordService {
    final requestApi;

    WordService(this.requestApi);

    bool isLoading = false; // 是否正在请求数据中
    bool _hasMore = true; // 是否还有更多数据可加载
    int _pageIndex = 0; // 页面的索引
    int _pageTotal = 0; // 页面的索引
    List items = List();

// list探底，执行的具体事件
    Future _getMoreData() async {
//
//            //if(_hasMore){ // 还有数据可以拉新
//            List newEntries = await mokeHttpRequest();
//            //if (newEntries.isEmpty) {
//            _hasMore = (_pageIndex <= _pageTotal);
//            if (this.mounted) {
//                setState(() {
//                    items.addAll(newEntries);
//                    isLoading = false;
//                });
//            }
    }

// 伪装吐出新数据
//    Future<List> mokeHttpRequest() async {
//        if (widget.requestApi is Function) {
//            final listObj = await widget.requestApi({'pageIndex': _pageIndex});
//            _pageIndex = listObj['pageIndex'];
//            _pageTotal = listObj['total'];
//            return listObj['list'];
//        } else {
//            return Future.delayed(Duration(seconds: 2), () {
//                return [];
//            });
//        }
//    }

}
