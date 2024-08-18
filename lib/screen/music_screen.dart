import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicplayer/model/state_notifier.dart';

class MusicScreen extends ConsumerStatefulWidget {
  const MusicScreen({super.key});

  @override
  ConsumerState<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends ConsumerState<MusicScreen> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = ref.watch(playerProvider);
    final musicNotifier = ref.watch(playerProvider.notifier);

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$minutes:$seconds";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MusicPlayer",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Image.asset(
                musicProvider.Image[musicProvider.currentSongIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    musicProvider.songtitle[musicProvider.currentSongIndex],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    musicProvider.singer[musicProvider.currentSongIndex],
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          formatDuration(musicProvider.position),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 25,
                            ),
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: Colors.grey,
                            thumbColor: Colors.blue,
                            overlayColor: Colors.red.withOpacity(0.2),
                          ),
                          child: Slider(
                            value: musicProvider.position.inSeconds.toDouble(),
                            min: 0.0,
                            max: musicProvider.duration.inSeconds.toDouble(),
                            onChanged: (double value) {
                              musicNotifier
                                  .seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          formatDuration(musicProvider.duration),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            musicNotifier.toggleRepeat();
                          },
                          icon: Icon(Icons.repeat,
                              color: musicProvider.isRepeating
                                  ? Colors.red
                                  : Colors.black)),
                      IconButton(
                          onPressed: () {
                            musicNotifier.previous();
                          },
                          icon: Icon(Icons.skip_previous)),
                      if (musicProvider.isPlaying)
                        IconButton(
                            onPressed: () {
                              musicNotifier.pause();
                            },
                            icon: Icon(Icons.pause))
                      else
                        IconButton(
                            onPressed: () {
                              musicNotifier.play();
                            },
                            icon: Icon(Icons.play_arrow)),
                      IconButton(
                          onPressed: () {
                            musicNotifier.next();
                          },
                          icon: Icon(Icons.skip_next)),
                      IconButton(
                          onPressed: () {
                            musicNotifier.toggleShuffle();
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: musicProvider.isShuffling
                                ? Colors.red
                                : Colors.black,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
