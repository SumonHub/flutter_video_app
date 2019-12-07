import 'package:flutter/material.dart';
import 'package:pokedex/ads/Ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String data;

  const VideoPlayer({Key key, @required this.data}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with TickerProviderStateMixin {
  String _videoId;
  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    Ads.hideBannerAd();

    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //  AIzaSyBs5SHwVdGxRJcj7VcLHwzhh0DOGuBqEYY

  @override
  Widget build(BuildContext context) {
    _videoId = widget.data;

    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
      ),
    )..addListener(listener);

    Widget yt() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Material(
          color: Color(0XFFFFFFFF),
          elevation: 2.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Container which video tumbnail
              Expanded(
                flex: 0,
                child: Container(
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(12.0),
                      ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: YoutubePlayer(
                      bufferIndicator: RichText(
                          text: TextSpan(
                              text: ' Awaiting... ',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ))),
                      width: MediaQuery.of(context).size.width,
                      controller: _controller,
                      onReady: () {
                        _isPlayerReady = true;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/home_clean.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[yt()],
          )
        ],
      ),
    );
  }
}
