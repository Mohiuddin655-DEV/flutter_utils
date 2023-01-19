import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../utils/configurations/size_config.dart';

class VideoView extends StatefulWidget {
  final bool loopingEnable;
  final bool autoPlay;
  final double? borderRadius;
  final double? width, height;
  final double? space;
  final dynamic video;
  final VideoType videoType;
  final PodPlayerController? controller;

  const VideoView({
    Key? key,
    this.autoPlay = true,
    this.loopingEnable = false,
    this.borderRadius,
    this.width,
    this.height,
    this.space,
    this.video,
    this.controller,
    this.videoType = VideoType.detect,
  }) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late PodPlayerController _controller;
  late Size size = MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        PodPlayerController(
          podPlayerConfig: PodPlayerConfig(
            autoPlay: widget.autoPlay,
            isLooping: widget.loopingEnable,
          ),
          playVideoFrom: player,
        )
      ..initialise();
  }

  VideoType get type {
    final video = widget.video;
    if (video is String) {
      if (video.contains(VideoType.youtube.value)) {
        return VideoType.youtube;
      } else if (video.contains(VideoType.vimeo.value)) {
        return VideoType.vimeo;
      } else if (video.contains(VideoType.asset.value)) {
        return VideoType.asset;
      } else {
        return widget.videoType;
      }
    } else {
      return widget.videoType;
    }
  }

  PlayVideoFrom get player {
    final video = widget.video ?? '';
    switch (type) {
      case VideoType.asset:
        return PlayVideoFrom.asset(video);
      case VideoType.file:
        return PlayVideoFrom.file(video);
      case VideoType.vimeo:
        return PlayVideoFrom.vimeo(video);
      case VideoType.youtube:
        return PlayVideoFrom.youtube(video);
      case VideoType.detect:
      default:
        return PlayVideoFrom.network(video);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig.of(context);
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          config.pixel(widget.borderRadius),
        ),
      ),
      margin: EdgeInsets.all(config.pixel(widget.space)),
      child: PodVideoPlayer(
        controller: _controller,
      ),
    );
  }

  bool get isBuffering => _controller.isVideoBuffering;

  bool get isInitialized => _controller.isInitialised;

  bool get isLooping => _controller.isVideoLooping;

  bool get isPlaying => _controller.isVideoPlaying;

  void onPause() => _controller.pause();

  void onPlay() => _controller.play();
}

enum VideoType {
  detect("detect"),
  asset("assets/"),
  file("file"),
  youtube("https://www.youtube.com"),
  vimeo("https://player.vimeo.com");

  const VideoType(this.value);

  final String value;
}
