import 'package:flutter/material.dart';
import 'package:flutter_utils/core/utils/size_config.dart';
import 'package:pod_player/pod_player.dart';

class VideoView extends StatefulWidget {
  final bool loopingEnable;
  final bool autoPlay;
  final double? borderRadius;
  final double? width, height;
  final double? space;
  final dynamic video;
  final VideoType videoType;

  const VideoView({
    Key? key,
    this.autoPlay = true,
    this.loopingEnable = false,
    this.borderRadius,
    this.width,
    this.height,
    this.space,
    this.video,
    this.videoType = VideoType.none,
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
    _controller = PodPlayerController(
      podPlayerConfig: PodPlayerConfig(
        autoPlay: widget.autoPlay,
        isLooping: widget.loopingEnable,
      ),
      playVideoFrom: player,
    )..initialise();
  }

  PlayVideoFrom get player {
    final video = widget.video ?? '';
    switch (widget.videoType) {
      case VideoType.asset:
        return PlayVideoFrom.asset(video);
      case VideoType.file:
        return PlayVideoFrom.file(video);
      case VideoType.vimeo:
        return PlayVideoFrom.vimeo(video);
      case VideoType.youtube:
        return PlayVideoFrom.youtube(video);
      case VideoType.none:
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
  none,
  asset,
  file,
  youtube,
  vimeo,
}
