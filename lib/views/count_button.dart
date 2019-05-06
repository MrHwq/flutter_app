import 'package:flutter/material.dart';

class CountButton extends StatefulWidget {
    @override
    _CounteState createState() {
        return _CounteState();
    }
}

class CountAdd extends StatelessWidget {
    CountAdd({this.onPressed});

    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return RaisedButton(onPressed: this.onPressed, child: Text('增加'));
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

class _CounteState extends State<CountButton> {
    int _count = 0;

    @override
    Widget build(BuildContext context) {
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                CountAdd(onPressed: () {
                    setState(() {
                        ++_count;
                    });
                }),
                CountDisplay(count: _count)
            ]);
    }
}