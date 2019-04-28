import 'package:flutter/material.dart';
import 'package:flutter_app/models/banner_base_item.dart';
import 'package:flutter_app/widgets/home_banner.dart';

class Pagination extends StatelessWidget {
    final List<BaseItem> items;
    final OnTapBannerItem onTap;

    Pagination({this.items, this.onTap});

    void _launchURL(String url) async {
//        if (await canLaunch(url)) {
//            await launch(url);
//        } else {
//            throw 'Could not launch $url';
//        }
    }

    List<Widget> _pageSelector(BuildContext context) {
        List<Widget> list = [];
        if (items.isNotEmpty) {
            list.add(HomeBanner(items, onTap));
        }
        return list;
    }

    @override
    Widget build(BuildContext context) {
        return Column(key: Key('__header__'),
            //physics: AlwaysScrollableScrollPhysics(),
            //padding: EdgeInsets.only(),
            children: _pageSelector(context));
    }
}