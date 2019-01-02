import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import '../config.dart';

class NewsList extends StatefulWidget {
  final String newsType;
  NewsList(this.newsType);
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  final String _url = 'http://v.juhe.cn/toutiao/index';
  final String _key = ConfigData.requestInfo[ 'key' ];

  Future<String> get(String type) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(
      '$_url?type=$type&key=$_key'
    ));
    var response = await request.close();
    return await response.transform(utf8.decoder).join();
  }

  Future<Null> loadData() async {
    await get(widget.newsType);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadData, // 类型必须为Future<Null>类型
      child: FutureBuilder(
        future: get(widget.newsType),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if(snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // 内部无须调用setState
                return _createListView(snapshot);
              }
          }
        },
      ),
    );
  }

  Widget _createListView(AsyncSnapshot snapshot) {
    List datas;
    final res = jsonDecode(snapshot.data);
    datas = res[ 'result' ] != null ? res[ 'result' ][ 'data' ] : [];
    if (datas.length > 0) {
      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index) {
          return _newsItem(datas[ index ]);
        },
      );
    } else {
      return Center(
        child: Card(
          child: Text(res[ 'reason' ]),
        ),
      );
    }
  }

  Widget _newsItem(newsInfo) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(newsInfo[ 'title' ]),
            padding: EdgeInsets.all(10),
          ),
          Column(
            children: <Widget>[
              _imageGrop(newsInfo),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(newsInfo[ 'author_name' ], style: Theme.of(context).textTheme.body2),
                    Text(newsInfo[ 'date' ], style: Theme.of(context).textTheme.body2),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageGrop(newsInfo) {var validType = [];
    const picTypes = [ 'thumbnail_pic_s', 'thumbnail_pic_s02', 'thumbnail_pic_s03' ];
    for (int item = 0; item < picTypes.length ; item++) {
      if (newsInfo[ picTypes[ item ] ] != null) {
        validType.add(newsInfo[ picTypes[ item ] ]);
      }
    }
    return Row(
      children: validType.map((item) {
        return Expanded(
          child: Container(
            padding: validType.length == 1 ? EdgeInsets.all(3) : EdgeInsets.all(4),
            child: SizedBox(
              child: FadeInImage.assetNetwork(
                image: item,
                placeholder: 'static/altImg.jpg',
                fit: BoxFit.fitWidth,
              ),
              height: validType.length == 1 ? 200 : null,
            )
          ),
        );
      }).toList(),
    );
  }
}