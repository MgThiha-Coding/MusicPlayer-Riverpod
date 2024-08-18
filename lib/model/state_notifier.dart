import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/model/model.dart';

class MusicPlayerNotifier extends StateNotifier<MusicPlayer> {
  final AudioPlayer player = AudioPlayer();
  MusicPlayerNotifier({
    required List<String> playlist,
    required List<String> songtitle,
    required List<String> singer,
    required List<String> Image,
  }) : super(MusicPlayer(
          isPlaying: false,
          isRepeating: false,
          isShuffling: false,
          position: Duration.zero,
          duration: Duration.zero,
          currentSongIndex: 0,
          playlist: playlist,
          songtitle: songtitle,
          singer: singer,
          Image: Image,
        )) {
    initializePlayer();
    load(playlist[0]);
  }
  // initialize
  void initializePlayer() async {
    player.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    player.durationStream.listen((duration) {
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });

    player.processingStateStream.listen((processingState) {
      if (player.processingState == ProcessingState.completed) {
        if (state.isRepeating) {
          player.seek(Duration.zero);
        } else {
          next();
        }
      }
    });
  }

  // load
  Future<void> load(String assetPath) async {
    await player.setAsset(assetPath);
    final duration = player.duration;
    if (duration != null) {
      state = state.copyWith(
        position: player.position,
        duration: duration,
      );
    }
  }

  // play
  void play() {
    player.play();
    state = state.copyWith(isPlaying: true);
  }

  // pause
  void pause() {
    player.pause();
    state = state.copyWith(isPlaying: false);
  }

  // next
  void next() async {
    int nextInt;
    if (state.isShuffling) {
      nextInt = Random().nextInt(state.playlist.length);
    } else {
      nextInt = (state.currentSongIndex + 1) % state.playlist.length;
    }

    // Update the state before loading the next track
    state = state.copyWith(currentSongIndex: nextInt);
    await load(state.playlist[nextInt]);
    play();
  }

  // previous
  void previous() async {
    if (state.currentSongIndex > 0) {
      state = state.copyWith(currentSongIndex: state.currentSongIndex - 1);
    } else {
      state = state.copyWith(currentSongIndex: state.playlist.length - 1);
    }
    load(state.playlist[state.currentSongIndex]);
    play();
  }

  // repeat & shuffle
  void toggleRepeat() {
    state = state.copyWith(isRepeating: !state.isRepeating);
  }

  void toggleShuffle() {
    state = state.copyWith(isShuffling: !state.isShuffling);
  }

  // seek
  Future seek(Duration position) async {
    await player.seek(position);
    state = state.copyWith(position: position);
  }

  // seekto
  Future<void> seekTo(int index) async {
    if (index >= 0 && index < state.playlist.length) {
      // Get the current position if the same song is selected, otherwise reset position
      final currentPosition =
          (state.currentSongIndex == index) ? player.position : Duration.zero;

      // Update state with the new song index and position
      state = state.copyWith(
        currentSongIndex: index,
        position: currentPosition,
      );

      // Load the new song and seek to the position
      await load(state.playlist[index]);

      // Seek to the saved position
      if (currentPosition != Duration.zero) {
        await seek(currentPosition);
      }

      // Play the song
      play();
    }
  }
}

final playerProvider =
    StateNotifierProvider<MusicPlayerNotifier, MusicPlayer>((ref) {
  return MusicPlayerNotifier(playlist: [
    'assets/song1.mp3',
    'assets/song2.mp3',
    'assets/song3.mp3',
    'assets/song4.mp3',
    'assets/song5.mp3',
    'assets/song6.mp3',
    'assets/song7.mp3',
    'assets/song8.mp3',
    'assets/song9.mp3',
    'assets/song10.mp3',
    'assets/song11.mp3',
    'assets/song12.mp3',
  ], songtitle: [
    'Wake Me Up',
    'Levels',
    'Hey Brother',
    'The Nights',
    'Waiting For Love',
    'Without You',
    'Lonely Together',
    'You Make Me',
    'Silhouettes',
    'I Could Be The One',
    'Addicted To You',
    'Broken Arrow',
  ], singer: [
    "Avicii, Aloe Blacc",
    "Avicii",
    "Avicii",
    "Avicii",
    "Avicii",
    "Avicii, Sandro Cavazza",
    "Avicii, Rita Ora",
    "Avicii",
    "Avicii",
    "Avicii, Nicky Romero",
    "Avicii, Audra Mae",
    "Avicii, Alex Ebert",
  ], Image: [
    'assets/album/image1.jpg',
    'assets/album/image2.jpg',
    'assets/album/image3.jpg',
    'assets/album/image4.jpg',
    'assets/album/image5.jpg',
    'assets/album/image6.jpg',
    'assets/album/image7.jpg',
    'assets/album/image8.jpg',
    'assets/album/image9.jpg',
    'assets/album/image10.jpg',
    'assets/album/image11.jpg',
    'assets/album/image12.jpg',
  ]);
});
