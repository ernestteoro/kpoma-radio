import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

import 'djoma_live_tv.dart';

class MyApp extends StatefulWidget {
  final playerState = FlutterRadioPlayer.flutter_radio_paused;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0, radioIndex = 0;
  double volume = 0.8;
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  final List<Widget> _pages =[

  ];

  // TV channel URL // https://djoma.stream-broadcast.ovh/djoma-hls/index.m3u8

  final List<String> _listChannel = [
    "http://stream1.broadcast-associes.com:8000/sweet_guinee",
    "http://stream1.broadcast-associes.com:8000/espace_guinee",
    "http://node-19.zeno.fm/uqveb600hyduv?1550492673872=&rj-ttl=5&rj-token=AAABaQCZ0Iz8CPV7jRhZEDK4-GuTZ9O7dM-CBKFhYOxrwOUWBdVz7Q&rj-tok=AAABgbCB3zEAnYuuB8bJ9oW1VQ",
    "https://25043.live.streamtheworld.com/NAUFMAAC_SC",
    "http://node-22.zeno.fm/0zrvh4rpxa5tv?rj-ttl=5&rj-tok=AAABgbEVNz4A6JF8Lzadd7BDLA"
  ];

  @override
  void initState() {
    super.initState();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
        "Djoma FM",
        "Live",
        "https://stream3.broadcast-associes.com/djoma-radio.mp3",
        "false",
      );
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }
  /*
  _currentIndex == 0 ? buildFmBody():Center(
          child: DjomTvHomePage(),
        )
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Djoma FM"),
        ),
        body: _currentIndex == 0 ?
        Center(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: _flutterRadioPlayer.isPlayingStream,
                initialData: widget.playerState,
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String returnData = snapshot.data!;
                  switch (returnData) {
                    case FlutterRadioPlayer.flutter_radio_stopped:
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        child: const Text("Start listening now"),
                        onPressed: () async {
                          await initRadioService();
                        },
                      );
                      break;
                    case FlutterRadioPlayer.flutter_radio_loading:
                      return const Text("Loading stream...");
                    case FlutterRadioPlayer.flutter_radio_error:
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        child: const Text("Retry ?"),
                        onPressed: () async {
                          await initRadioService();
                        },
                      );
                      break;
                    default: return Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              await _flutterRadioPlayer.playOrPause();
                            },
                            icon: snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_playing
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                          ),
                          IconButton(
                            onPressed: () async {
                              await _flutterRadioPlayer.stop();
                            },
                            icon: const Icon(Icons.stop),
                          )
                        ],
                      ),
                    );break;
                  }
                },
              ),
              Slider(
                value: volume,
                min: 0,
                max: 1.0,
                onChanged: (value) => setState(
                      () {
                    volume = value;
                    _flutterRadioPlayer.setVolume(volume);
                  },
                ),
              ),
              Text(
                "Volume: ${(volume * 100).toStringAsFixed(0)}",
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Metadata Track "),
            ],
          ),
        ):
        Home(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.radio),
              label: "Djoma FM",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: "Djoma TV",
            )
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }


  Center buildFmBody(){
    return Center(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: _flutterRadioPlayer.isPlayingStream,
            initialData: widget.playerState,
            builder:
                (BuildContext context, AsyncSnapshot<String?> snapshot) {
              String returnData = snapshot.data!;
              switch (returnData) {
                case FlutterRadioPlayer.flutter_radio_stopped:
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    child: const Text("Ecouter"),
                    onPressed: () async {
                      await initRadioService();
                    },
                  );
                  break;
                case FlutterRadioPlayer.flutter_radio_loading:
                  return const Text("Chargement encours...");
                case FlutterRadioPlayer.flutter_radio_error:
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    child: const Text("Réessayer ?"),
                    onPressed: () async {
                      await initRadioService();
                    },
                  );
                  break;
                default: return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          await _flutterRadioPlayer.playOrPause();
                        },
                        icon: snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_playing
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _flutterRadioPlayer.stop();
                        },
                        icon: const Icon(Icons.stop),
                      )
                    ],
                  ),
                );break;
              }
            },
          ),
          Slider(
            value: volume,
            min: 0,
            max: 1.0,
            onChanged: (value) => setState(
                  () {
                volume = value;
                _flutterRadioPlayer.setVolume(volume);
              },
            ),
          ),
          Text(
            "Volume: ${(volume * 100).toStringAsFixed(0)}",
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

}
