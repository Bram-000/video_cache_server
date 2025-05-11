import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:video_cache_server_example/widget/player.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List data;

  @override
  void initState() {
    super.initState();
    data = [
      {
        'name': 'M3U8',
        'url': 'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8',
      },
      {
        'name': 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        'url': 'https://media.w3.org/2010/05/sintel/trailer.mp4'
      },
      {
        'name': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      }
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: data.map((item) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    margin: EdgeInsets.only(bottom: 12.0),
                    color: Theme.of(context).cardColor,
                    child: Row(
                      children: [
                        Expanded(child: Text(item['name'] as String)),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.play_arrow_sharp),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(PageRouteBuilder(pageBuilder: (context, animation, nextAnimation) => PlayerWidget(item['name'] as String, item['url'] as String)));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
