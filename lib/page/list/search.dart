import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SharedPreferences storage;
  List<String> searchList = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Future<SharedPreferences> getStorage () async {
    return await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (_, theme) {
        return _buildSearch(theme);
      },
      converter: (Store store) => store.state.themeGroup,
    );
  }

  Widget _buildSearch(theme) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
            hintText: '搜索更多...',
            prefixIcon: Icon(Icons.search),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(3.0),
              )
            ),
            filled: true,
            fillColor: theme.otherData.inputTheme.fillColor,
          ),
          onSubmitted: _inputSubmit,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text('搜索历史：', style: TextStyle(
              fontSize: 16
            )),
            margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
          ),
          FutureBuilder(
            future: getStorage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return searchList == [] ? Center(
                      child: CircularProgressIndicator(),
                    ) : listBuild(theme);
                default:
                  if(snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    storage = snapshot.data;
                    searchList = storage.getStringList('searchList') ?? [];
                    return listBuild(theme);
                  }
                  break;
              }
            },
          ),
        ],
      ),
    ); 
  }
  void _inputSubmit(String text) {
    if (text.isNotEmpty) {
      searchList.add(text);
      storage.setStringList('searchList', searchList);
      controller.clear();
    }
  }

  void _removeItem(int index) {
    searchList.removeAt(index);
    storage.setStringList('searchList', searchList);
    setState(() {
      searchList = searchList;
    });
  }

  Widget listBuild(theme) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: theme.otherData.cardBoard),
            ),
            child: ListTile(
              leading: Icon(Icons.av_timer, color: Theme.of(context).textTheme.body2.color),
              title: Text(searchList[ index ], style: Theme.of(context).textTheme.body2),
              trailing: IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).textTheme.body2.color),
                onPressed: () => _removeItem(index),
              ),
            )
          );
        },
        itemCount: searchList.length,
      ),
    );
  }
}