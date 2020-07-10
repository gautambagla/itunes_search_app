import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player.dart';
import 'itunes_model.dart';

class TrackViews extends StatefulWidget {

  final Track track;
  TrackViews({@required this.track});

  @override
  _TrackViewsState createState() => _TrackViewsState();
}

class _TrackViewsState extends State<TrackViews> {

  bool flipped = false ;
  GlobalKey<FlipCardState> flipKey  = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String time;
    if(widget.track.trackTimeMillis != null) {
      String secondFlag , minuteFlag ;
      int seconds = widget.track.trackTimeMillis ~/ 1000 ;
      int minutes = seconds ~/ 60 ;
      seconds = seconds % 60 ;
      if(minutes < 10)
        minuteFlag = "0" ;
      if(seconds < 10)
        secondFlag = "0" ;
      time = (minuteFlag ?? '') + minutes.toString() + ':' + (secondFlag ?? '') + seconds.toString();
    }
    return GestureDetector(
      onTap: ()=> flipKey.currentState.toggleCard(),
      child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
            FlipCard(
              flipOnTouch: false,
              key: flipKey,
              speed: 350,
              front: Card(
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.4),
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 12),
                clipBehavior: Clip.hardEdge,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 175,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 150,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.track.trackName ?? 'AudioBook', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), maxLines: 2, overflow: TextOverflow.ellipsis,),
                            Container(height: 5,),
                            Text(widget.track.artistName ?? 'Artist name not available', style: TextStyle(fontSize: 14, color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis,),
                            Container(height: 5,),
                            Text(widget.track.collectionName ??'', style: TextStyle(fontSize: 13, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              back: Card(
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.4),
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 12),
                clipBehavior: Clip.hardEdge,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: widget.track.previewUrl == null ? Text('No audio preview available!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),) :
                        Player(url: widget.track.previewUrl)
                      ),
                    ),
                    Container(width: 175,),
                  ],
                ),
              ),
              onFlip: (){
                setState(() {
                  flipped = !flipped ;
                });
              },
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              left: flipped ? MediaQuery.of(context).size.width - (175+8) : 8,
              right: flipped ? 8 : MediaQuery.of(context).size.width - (175+8) ,
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.bottomRight,
                  height: 175,
                    width: 175,
                  child: Text(
                    time ?? '',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black.withOpacity(0.7))]),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.track.artworkUrl600 ??
                                widget.track.artworkUrl100 ??
                                'https://cdn.vox-cdn.com/thumbor/ylWtwM0OgSsr89Vv_KXH22Zdr3E=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/9879095/C_j1HJ5XoAAR7c5.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}
