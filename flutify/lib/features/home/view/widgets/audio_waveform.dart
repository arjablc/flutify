import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../../core/theme/app_pallete.dart';

class AudioWaveForm extends StatefulWidget {
  const AudioWaveForm({super.key, required this.path});
  final String path;

  @override
  State<AudioWaveForm> createState() => _AudioWaveFormState();
}

class _AudioWaveFormState extends State<AudioWaveForm> {
  final PlayerController _controller = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await _controller.preparePlayer(path: widget.path);
  }

  Future<void> playAndPause() async {
    if (!_controller.playerState.isPlaying) {
      await _controller.startPlayer(finishMode: FinishMode.stop);
    } else if (!_controller.playerState.isPaused) {
      await _controller.pausePlayer();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          IconButton(
              icon: Icon(
                  _controller.playerState == PlayerState.playing
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  color: Pallete.whiteColor),
              onPressed: playAndPause),
          AudioFileWaveforms(
            size: const Size(double.infinity, 45),
            playerController: _controller,
            playerWaveStyle: const PlayerWaveStyle(
                seekLineColor: Pallete.gradient2,
                fixedWaveColor: Pallete.borderColor,
                liveWaveColor: Pallete.gradient1),
          ),
        ],
      ),
    );
  }
}
