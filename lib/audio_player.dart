import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Player extends StatefulWidget {
  final String url ;
  Player({this.url});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _player ;
  @override
  void initState() {
    _player = AudioPlayer();
    _player.setUrl(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FullAudioPlaybackState>(
      stream: _player.fullPlaybackStateStream,
      builder: (context, snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.state;
        final buffering = fullState?.buffering;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state == AudioPlaybackState.connecting ||
                buffering == true)
              Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              )
            else if (state == AudioPlaybackState.playing)
              IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: _player.pause,
              )
            else
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: _player.play,
              ),
            IconButton(
              icon: Icon(Icons.stop),
              iconSize: 64.0,
              onPressed: state == AudioPlaybackState.stopped ||
                  state == AudioPlaybackState.none
                  ? null
                  : _player.stop,
            ),
          ],
        );
      },
    );
  }
}
