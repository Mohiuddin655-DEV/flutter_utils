import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../utils/configurations/size_config.dart';

class StreamVideoView extends StatefulWidget {
  final String videoUrl;
  final bool loopingEnable;
  final bool autoPlay;
  final double? borderRadius;
  final double? width, height;
  final double? space;

  const StreamVideoView({
    Key? key,
    required this.videoUrl,
    this.autoPlay = true,
    this.loopingEnable = false,
    this.borderRadius,
    this.width,
    this.height,
    this.space,
  }) : super(key: key);

  @override
  State<StreamVideoView> createState() => _StreamVideoViewState();
}

class _StreamVideoViewState extends State<StreamVideoView> {
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
      playVideoFrom: PlayVideoFrom.network(widget.videoUrl),
    )..initialise();
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
        backgroundColor: Colors.black,
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
