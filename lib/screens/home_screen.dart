import 'package:flutter/material.dart';
import 'package:khi_baja_app/screens/lyrics_screen.dart';
import '../models/song.dart';

class HomePage extends StatelessWidget {
  final List<Song> songs = [
    Song(title: "Song One", lyrics: "Lyrics one"),
    Song(title: "Song Two", lyrics: "Lyrics two"),
    Song(title: "Song Three", lyrics: "Lyrics three"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khi Baja Songs"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 154, 60, 34),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: songs.length,
        separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            title: Text(
              song.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(
              Icons.music_note,
              color: Color.fromARGB(255, 154, 60, 34),
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LyricsScreen(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
