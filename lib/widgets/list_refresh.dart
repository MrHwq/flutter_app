import 'package:flutter/material.dart';

class ListRefresh extends StatefulWidget {
    final renderItem;
    final headerView;
    final refresh;
    final more;

    const ListRefresh([this.renderItem, this.headerView, this.refresh, this.more]) :super();

    @override
    State<StatefulWidget> createState() => _ListRefreshState(refresh, more);
}

class _ListRefreshState extends State<ListRefresh> {
    bool isLoading = false; // 是否正在请求数据中
    bool _hasMore = true; // 是否还有更多数据可加载
    List items = List();
    final refresh;
    final more;
    ScrollController _scrollController = ScrollController();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

    _ListRefreshState(this.refresh, this.more);

    @override
    void initState() {
        super.initState();
        if (refresh is! Function) {
            throw ArgumentError("has no refresh function");
        }
        if (this.mounted) {
            setState(() {
                isLoading = true;
                _hasMore = true;
            });
        }
        if (isLoading) {
            refresh().then((data) {
                items.clear();
                print(data);
                setState(() {
                    items.addAll(data);
                    _hasMore = data is List && data.isNotEmpty;
                    isLoading = false;
                });
                backElasticEffect();
            }).catchError((err) {
                print(err);
                if (mounted) {
                    setState(() {
                        _hasMore = false;
                        isLoading = false;
                    });
                }
                backElasticEffect();
            });
        }

        _scrollController.addListener(() {
            // 如果下拉的当前位置到scroll的最下面
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                setState(() {
                    isLoading = true;
                });
                more().then((data) {
                    setState(() {
                        items.addAll(data);
                        _hasMore = data is List && data.isNotEmpty;
                        isLoading = false;
                    });
                    backElasticEffect();
                }).catchError((err) {
                    setState(() {
                        _hasMore = false;
                        isLoading = false;
                    });
                    backElasticEffect();
                });
            }
        });
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
//                duration: new Duration(milliseconds: 1000),
//                curve: Curves.easeOut);
//        }
    }

    // 加载中的提示
    Widget _buildLoadText() {
        return Container(
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: Text("数据没有更多了！！！"),
                ),
            ));
    }

    // 上提加载loading的widget,如果数据到达极限，显示没有更多
    Widget _buildProgressIndicator() {
        if (_hasMore) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Column(
                    children: <Widget>[
                        Opacity(opacity: isLoading ? 1.0 : 0.0,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue))
                        ),
                        SizedBox(height: 20.0),
                        Text('加载更多数据...', style: TextStyle(fontSize: 14.0))
                    ])));
        } else {
            return _buildLoadText();
        }
    }

    @override
    void dispose() {
        super.dispose();
        _scrollController.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(key: _refreshIndicatorKey,
            child: ListView.separated(
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                    print('index:$index length:${items.length}');
                    if (index == 0 && index != items.length) {
                        if (widget.headerView is Function) {
                            return widget.headerView();
                        } else {
                            return Container(height: 0);
                        }
                    }
                    if (index == items.length) {
                        //return _buildLoadText();
                        return _buildProgressIndicator();
                    } else {
                        //print('itemsitemsitemsitems:${items[index].title}');
                        //return ListTile(title: Text("Index${index}:${items[index].title}"));
                        if (widget.renderItem is Function) {
                            return widget.renderItem(index, items[index]);
                        } else {
                            throw ArgumentError("renderItem is not function");
                        }
                    }
                },
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
            ),
            onRefresh: () async {
                final data = await refresh();
                Scaffold.of(_refreshIndicatorKey.currentContext)
                    .showSnackBar(SnackBar(content: Text("刷新成功")));
                items.clear();
                setState(() {
                    items.addAll(data);
                    _hasMore = data is List && data.isNotEmpty;
                    isLoading = false;
                });
                backElasticEffect();
                return null;
            });
    }
}
