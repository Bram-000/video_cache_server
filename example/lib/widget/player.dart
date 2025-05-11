import 'dart:io';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_cache_server/video_cache_server.dart';
import 'package:video_cache_server_example/widget/cache_preview.dart';


const String PLAYER_VIDEOPLAYER = 'video_player';

class PlayerWidget extends StatefulWidget {
  final String name;
  final String url;

  PlayerWidget(this.name, this.url);

  @override
  State createState() => PlayerWidgetState();
}

class PlayerWidgetState extends State<PlayerWidget> {
  String playerType = PLAYER_VIDEOPLAYER;
  VideoCacheServer? server;
  String? proxyUrl;

  PlayerWidgetState();

  void switchPlayer(String newPlayerType) async {
    if (newPlayerType == playerType) {
      return;
    }
    if (mounted) {
      setState(() {
        playerType = newPlayerType;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTemporaryDirectory().then((tmpDir) {
      server = VideoCacheServer(
          httpClient: HttpClient(),
          cacheDir: '${tmpDir.path}/video_cache_server/${Uri.encodeComponent(widget.url)}/')
        ..start().then((_) {
          proxyUrl = _.getProxyUrl(widget.url);
          if (mounted) {
            setState(() {});
          }
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    server?.stop(widget.url);
    server?.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (server == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: server!.started ? (VideoPlayerWidget(proxyUrl!)) : Container(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Text(widget.name),
          ),
          Container(
            child: Row(
              children: [
                // Expanded(
                //   child: Row(
                //     children: [
                //       Radio(
                //         groupValue: playerType,
                //         value: PLAYER_FIJKPLAYER,
                //         onChanged: (value) {
                //           switchPlayer(value as String);
                //         },
                //       ),
                //       Text(PLAYER_FIJKPLAYER),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        groupValue: playerType,
                        value: PLAYER_VIDEOPLAYER,
                        onChanged: (value) {
                          switchPlayer(value as String);
                        },
                      ),
                      Text(PLAYER_VIDEOPLAYER),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CachePreview(widget.url, server!, 40),
        ],
      ),
    );
  }
}

// class FijkPlayerWidget extends StatefulWidget {
//   final String url;
//
//   FijkPlayerWidget(this.url);
//
//   @override
//   State createState() => FijkPlayerWidgetState();
// }

// class FijkPlayerWidgetState extends State<FijkPlayerWidget> {
//   final FijkPlayer _fijkPlayer = FijkPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//     FijkLog.setLevel(FijkLogLevel.Error);
//     _fijkPlayer.addListener(() {
//       if (_fijkPlayer.value.state == FijkState.error) {
//         log('Error:${_fijkPlayer.value.exception}');
//       }
//     });
//     _fijkPlayer.setDataSource(widget.url, autoPlay: true);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _fijkPlayer.release();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FijkView(
//       fs: false,
//       player: _fijkPlayer,
//     );
//   }
// }

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget(this.url);

  @override
  State createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoController? _controller;
  var videoPlayer = Player(); // 卡片视频

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.url)
    //   ..initialize().then((value) {
    //     if (mounted) {
    //       setState(() {});
    //     }
    //   });
    _controller = VideoController(videoPlayer);
    videoPlayer.open(Media(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: Video(
        controller: _controller!,
        fill: Colors.transparent,
      ),
    );
  }
}
