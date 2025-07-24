import 'package:flutter/material.dart';
import '../models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class LyricsScreen extends StatefulWidget {
  final Song song;

  const LyricsScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Load your audio file dynamically here
    _audioPlayer.setSource(AssetSource('audios/sample_song.mp3'));

    // Listen to audio duration changes
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to audio position changes
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    // When audio finishes playing
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('audios/sample_song.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void seekToSeconds(int seconds) {
    final newPosition = Duration(seconds: seconds);
    _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Music player controls
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                  onPressed: togglePlayPause,
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.deepPurple.shade100,
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble().clamp(
                      0,
                      duration.inSeconds.toDouble(),
                    ),
                    onChanged: (value) {
                      seekToSeconds(value.toInt());
                    },
                  ),
                ),
                Text(formatTime(position), style: TextStyle(fontSize: 14)),
                SizedBox(width: 8),
                Text(
                  formatTime(duration),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Lyrics
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.song.lyrics,
                  style: TextStyle(fontSize: 18, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
