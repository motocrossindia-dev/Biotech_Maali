import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoplayerWidget extends StatefulWidget {
  const VideoplayerWidget({super.key});

  @override
  State<VideoplayerWidget> createState() => _VideoplayerWidgetState();
}

class _VideoplayerWidgetState extends State<VideoplayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.videvo.net/video/drone-shot-of-a-beautiful-golf-course/2253803/#rs=video-box',
    )..initialize().then((_) {
        setState(() {});
      })..addListener(() {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      // Provide a fixed height for the video container
      height: MediaQuery.of(context).size.height * 0.4, // Adjust this value based on your needs
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        _PlayPauseOverlay(
                          controller: _controller,
                          isPlaying: _isPlaying,
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          const SizedBox(height: 8),
          // Progress bar
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () {
                  final position = _controller.value.position -
                      const Duration(seconds: 10);
                  _controller.seekTo(position);
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () {
                  final position = _controller.value.position +
                      const Duration(seconds: 10);
                  _controller.seekTo(position);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({
    required this.controller,
    required this.isPlaying,
  });

  final VideoPlayerController controller;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Container(
        color: Colors.black26,
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}