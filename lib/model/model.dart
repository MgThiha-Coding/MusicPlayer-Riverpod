class MusicPlayer {
  final bool isPlaying;
  final bool isRepeating;
  final bool isShuffling;
  // boolean value for play,pause,repeat and shuffle
  final Duration position;
  final Duration duration;
  // Duration value for music index positon and slider duration
  final int currentSongIndex;
  // int (index) value for currentSongIndex
  final List<String> playlist;
  final List<String> songtitle;
  final List<String> singer;
  final List<String> Image;
  // List data for playlist , songtitle and vacalist
  MusicPlayer({
    required this.isPlaying,
    required this.isRepeating,
    required this.isShuffling,
    required this.position,
    required this.duration,
    required this.currentSongIndex,
    required this.playlist,
    required this.songtitle,
    required this.singer,
    required this.Image,
  }); // built a constructor
  MusicPlayer copyWith({
    bool? isPlaying,
    bool? isRepeating,
    bool? isShuffling,
    Duration? position,
    Duration? duration,
    int? currentSongIndex,
    List<String>? playlist,
    List<String>? songtitle,
    List<String>? singer,
    List<String>? Image
     // optional parameters
  }) {
    return MusicPlayer(
      isPlaying: isPlaying ?? this.isPlaying,
      isRepeating: isRepeating ?? this.isRepeating,
      isShuffling: isShuffling ?? this.isShuffling,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentSongIndex: currentSongIndex ?? this.currentSongIndex,
      playlist: playlist ?? this.playlist,
      songtitle: songtitle ?? this.songtitle,
      singer: singer ?? this.singer,
      Image: Image?? this.Image,
    ); // null checking
  }
}
