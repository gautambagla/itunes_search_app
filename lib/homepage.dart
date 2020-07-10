import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'track_views.dart';
import 'api.dart';
import 'itunes_model.dart';
import 'loader.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false ;
  int opacity = 0;
  Search search ;
  List<Track> trackList = [] ;
  FocusNode _focusNode ;
  TextEditingController searchController ;
  ScrollController _scrollController ;
  @override
  void initState() {
    super.initState();
    search = Search();
    _focusNode = FocusNode();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController..addListener(() {
      //print(_scrollController.offset);
      if(_scrollController.offset < 255 && _scrollController.offset >= 0) {
        setState(() {
          opacity = _scrollController.offset ~/ 2 ;
        });
        print(opacity);
      }
    });
    //search.fetch('apple');
  }

  getTracks(String query) async {
    trackList.removeRange(0, trackList.length);
    setState(() {
      loading = true ;
    });
    await search.fetch(query);
    trackList = search.tracks.map((e) => e).toList();
    setState(() {
      loading = false ;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[200],
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: Container(height: 16,),),
                SliverFloatingBar(
                  backgroundColor: Colors.grey[200],
                  elevation: loading ? 0 : 8,
                  floating: true,
                  title: TextFormField(
                    cursorColor: Colors.grey,
                    enabled: !loading,
                    controller: searchController,
                    focusNode: _focusNode,
                    autofocus: false,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => searchController.clear(),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      _focusNode.unfocus();
                      getTracks(value);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: (!loading && trackList.length==0) ? Container(alignment: Alignment.center, height: MediaQuery.of(context).size.height - 216,child: Text('There\'s lonely in here.'),): Container(height: 16,),
                ),
                loading ? Loader() : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) => TrackViews(track: trackList[index]),
                      childCount: trackList.length,
                    addAutomaticKeepAlives: true,
                  ),
                )
              ],
            ),
            Container(height: MediaQuery.of(context).padding.top, color: Colors.grey[200].withAlpha(opacity),),
          ],
        ),
      ),
    );
  }
}