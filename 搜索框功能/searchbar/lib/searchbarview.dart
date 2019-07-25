import 'package:flutter/material.dart';

import 'datasource.dart';

class SearchBarView extends StatefulWidget {
  @override
  _SearchBarViewState createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: SearchBarViewDelegate());
              }
          )
        ],
      ),
    );
  }
}

class SearchBarViewDelegate extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: ()=>query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ),
        onPressed: ()=>close(context,null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    //搜索结果
    List<String> result = List();
    //模拟搜索过程
    for (var str in sourceList){
      if (query.isNotEmpty && str.contains(query)){
          result.add(str);
      }
    }

    //展示搜索结果
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index)=>ListTile(
        title: Text(result[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggest = query.isEmpty ? suggestList : sourceList.where((input)=>input.startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggest.length,
        itemBuilder: (BuildContext context, int index)=>ListTile(
          title: RichText(
              text: TextSpan(
                text: suggest[index].substring(0, query.length),
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: suggest[index].substring(query.length),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}
