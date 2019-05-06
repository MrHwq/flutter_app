import 'package:flutter/material.dart';

class BaseItem {
    Widget image;
    String title;

    BaseItem(this.image, this.title);

    @override
    String toString() {
        return "Title:" + title;
    }

}