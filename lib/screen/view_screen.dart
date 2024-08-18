import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicplayer/model/state_notifier.dart';
import 'package:musicplayer/screen/music_screen.dart';

class ViewScreen extends ConsumerStatefulWidget {
  const ViewScreen({super.key});

  @override
  ConsumerState<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends ConsumerState<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = ref.watch(playerProvider);
    return Scaffold(
      floatingActionButton: GestureDetector(
         child: Container( 
           width: 60,
           height: 60,
           child: Center( 
              child:  
              musicProvider.isPlaying?
              IconButton(onPressed: (){
                ref.read(playerProvider.notifier).pause();
              }, icon: Icon(Icons.pause,color: Colors.white,)):
              IconButton(onPressed: (){
                ref.read(playerProvider.notifier).play();
              }, icon: Icon(Icons.play_arrow,color: Colors.white,))
           ),
           decoration: BoxDecoration(  
             borderRadius: BorderRadius.circular(100),
             color: Colors.blue,
           ),
         ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Music Player",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: ListView.builder(
            itemCount: musicProvider.playlist.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(musicProvider.Image[index]),
                  ),
                  title: Text(musicProvider.songtitle[index]),
                  subtitle: Text(musicProvider.singer[index]),
                  trailing: musicProvider.currentSongIndex == index
                      ? Icon(Icons.music_note,color: Colors.blue,)
                      : null,
                  onTap: () {
                    ref.read(playerProvider.notifier).seekTo(index);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> MusicScreen()));
                  },
                ),
              );
            }),
      ),
    );
  }
}
