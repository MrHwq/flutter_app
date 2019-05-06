import 'package:flutter/material.dart';

class ListRefresh extends StatefulWidget {
    final renderItem;
    final headerView;
    final Function refresh;
    final Function more;
    final IndexedWidgetBuilder separator;

    ListRefresh({this.renderItem, this.headerView, this.refresh, this.more, this.separator});

    @override
    State<StatefulWidget> createState() => _ListRefreshState();
}

class _ListRefreshState extends State<ListRefresh> {
    bool _isLoading = false; // 是否正在请求数据中
    bool _hasMore = true; // 是否还有更多数据可加载
    final List _items = List();
    final ScrollController _scrollCtrl = ScrollController();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<
        RefreshIndicatorState>();

    _ListRefreshState();

    _refresh() async {
        final data = await widget.refresh();
//        Scaffold.of(_refreshIndicatorKey.currentContext)
//            .showSnackBar(SnackBar(content: Text("刷新成功")));
        _items.clear();
        print('mount: $mounted');
        setState(() {
            _items.addAll(data ?? []);
            _hasMore = data is List && data.isNotEmpty;
            _isLoading = false;
        });
        if (_hasMore && _scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
            _more();
        }
//        backElasticEffect();
    }

    _more() async {
        if (!mounted) {
            print('is not mounted');
            return;
        }
        setState(() {
            _isLoading = true;
        });
        final data = await widget.more();
        setState(() {
            _items.addAll(data ?? []);
            _hasMore = data is List && data.isNotEmpty;
            _isLoading = false;
        });
        backElasticEffect();
    }

    @override
    void initState() {
        super.initState();
        if (widget.refresh is! Function) {
            throw ArgumentError("has no refresh function");
        }
        if (this.mounted) {
            setState(() {
                _isLoading = true;
                _hasMore = true;
            });
        }
        if (_isLoading) {
            _refresh();
        }

        if (widget.more is Function) {
            _scrollCtrl.addListener(() {
                // 如果下拉的当前位置到scroll的最下面
                if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
                    _more();
                }
            });
        }
    }

//  回弹效果
    backElasticEffect() {
//        double edge = 50.0;
//        double offsetFromBottom = _scrollController.position.maxScrollExtent -
//            _scrollController.position.pixels;
//        // 添加一个动画没有更多数据的时候 ListView 向下移动覆盖正在加载更多数据的标志
//        if (offsetFromBottom < edge) {
//            _scrollController.animateTo(
//                _scrollController.offset - (edge - offsetFromBottom),
//                duration: Duration(milliseconds: 1000),
//                curve: Curves.easeOut);
//        }
    }

    // 加载中的提示
    Widget _buildLoadText() {
        return Container(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(child: Text("数据没有更多了！！！"))
        ));
    }

    // 上提加载loading的widget,如果数据到达极限，显示没有更多
    Widget _buildProgressIndicator() {
        if (_hasMore) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Column(
                    children: <Widget>[
                        Opacity(opacity: _isLoading ? 1.0 : 0.0,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue))
                        ),
                        SizedBox(height: 20.0),
                        Text('加载更多数据...', style: TextStyle(fontSize: 14.0))
                    ])
                )
            );
        } else {
            return _buildLoadText();
        }
    }

    @override
    void dispose() {
        super.dispose();
        _scrollCtrl.dispose();
    }

    IndexedWidgetBuilder _itemBuilder() {
        return (context, index) {
            print('index:$index length:${_items.length}');
            if (index == 0 && index != _items.length) {
                if (widget.headerView is Function) {
                    return widget.headerView();
                } else {
                    return Container(height: 0);
                }
            }
            if (index == _items.length) {
                //return _buildLoadText();
                return _buildProgressIndicator();
            } else {
                //print('itemsitemsitemsitems:${items[index].title}');
                //return ListTile(title: Text("Index${index}:${items[index].title}"));
                if (widget.renderItem is Function) {
                    return widget.renderItem(index, _items[index]);
                } else {
                    throw ArgumentError("renderItem is not function");
                }
            }
        };
    }

    Widget get _child {
        print('get child how to render it');
        return widget.separator != null
            ? ListView.separated(
            itemCount: _items.length + 1,
            itemBuilder: _itemBuilder(), controller: _scrollCtrl,
            separatorBuilder: (BuildContext context, int index) => Divider(height: 1))
            : ListView.builder(itemCount: _items.length + 1,
            itemBuilder: _itemBuilder(),
            controller: _scrollCtrl);
    }

    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(key: _refreshIndicatorKey,
            child: _child,
            onRefresh: () async {
                await _refresh();
                return null;
            }
        );
    }
}
