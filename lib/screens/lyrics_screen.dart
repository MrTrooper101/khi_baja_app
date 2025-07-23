import 'package:flutter/material.dart';

import '../models/song.dart';

class LyricsScreen extends StatelessWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(song.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(song.lyrics, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
