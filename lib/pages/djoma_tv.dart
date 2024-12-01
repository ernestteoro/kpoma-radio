// TV channel URL // https://djoma.stream-broadcast.ovh/djoma-hls/index.m3u8


import 'package:flutter/material.dart';

class DjomTvHomePage extends StatefulWidget{

  @override
  _DjomTvHomePageState createState() => _DjomTvHomePageState();
}

class _DjomTvHomePageState extends State<DjomTvHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("This is media pa"),
      )
    );
  }

}


/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DjomTvHomePage extends StatefulWidget{

  @override
  _DjomTvHomePageState createState() => _DjomTvHomePageState();
}


class _DjomTvHomePageState extends State<DjomTvHomePage>{
  //String mediaUrl = "https://djoma.stream-broadcast.ovh/djoma-hls/index.m3u8";
  String mediaUrl = "https://www.youtube.com/watch?v=Vr1Tpgphs4A";
  late VideoPlayerController? _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    super.initState();
      _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      );

      _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_videoPlayerController!),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      _videoPlayerController!.value.isPlaying?
                      _videoPlayerController!.pause(): _videoPlayerController!.play();
                    },
                    icon: Icon(Icons.play_arrow),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: (){
                    if(_videoPlayerController!.value.isPlaying){
                      _videoPlayerController!.pause();
                    }
                  },
                  icon: Icon(Icons.pause),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.stop_circle),
                  color: Colors.black,
                )
              ],
            )


          ],
        ),
      ),
    );
  }


}

 */
