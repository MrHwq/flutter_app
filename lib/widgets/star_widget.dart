import 'package:flutter/material.dart';

class StarWidget extends StatefulWidget {

    @override
    _StarState createState() {
        return _StarState();
    }
}

class _StarState extends State<StarWidget> {
    bool _isStar = true;
    int _starCount = 41;
    bool hasStar;

    void handleTap() {
        hasStar = false;
    }

    @override
    Widget build(BuildContext context) {
        return Row(mainAxisSize: MainAxisSize.min,
            children: <Widget>[Container(padding: EdgeInsets.all(0),
                child: IconButton(icon: _isStar ? Icon(Icons.star) : Icon(Icons.star_border), color:
                Colors.red[500], onPressed: () {
                    setState(() {
                        if (_isStar) {
                            _starCount--;
                        } else {
                            _starCount++;
                        }
                        _isStar = !_isStar;
                    });
                })
            ),
            SizedBox(width: 18,
                child: Container(child: Text('$_starCount'))
            )
            ]
        );
    }
}