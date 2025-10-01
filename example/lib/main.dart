import 'package:flutter/material.dart';
import 'package:video_360/video_360.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Video360Controller? controller;

  String durationText = '';
  String totalText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video 360 Plugin example app'),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Video360View(
                url:
                    'https://firebasestorage.googleapis.com/v0/b/lbs-navigation.firebasestorage.app/o/review%2F%E1%84%8B%E1%85%A1%E1%86%A8%E1%84%92%E1%85%A7%E1%86%AB%E1%84%89%E1%85%A5%E1%86%BC%E1%84%83%E1%85%A1%E1%86%BC%20%E1%84%87%E1%85%A9%E1%84%92%E1%85%A2%E1%86%BC%E1%84%85%E1%85%A9%20%E1%84%89%E1%85%B5%E1%84%8C%E1%85%A1%E1%86%A8.mp4?alt=media&token=abb0c1ef-5830-4493-8819-ce290d573cd3',
                onVideo360ViewCreated: _onVideo360ViewCreated,
                onPlayInfo: (Video360PlayInfo info) {
                  setState(() {
                    durationText = info.duration.toString();
                    totalText = info.total.toString();
                  });
                },
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller?.play();
                    },
                    color: Colors.grey[100],
                    child: const Text('Play'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.stop();
                    },
                    color: Colors.grey[100],
                    child: const Text('Stop'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.reset();
                    },
                    color: Colors.grey[100],
                    child: const Text('Reset'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.jumpTo(80000);
                    },
                    color: Colors.grey[100],
                    child: const Text('1:20'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller?.seekTo(-2000);
                    },
                    color: Colors.grey[100],
                    child: const Text('<<'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.seekTo(2000);
                    },
                    color: Colors.grey[100],
                    child: const Text('>>'),
                  ),
                  Flexible(
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.grey[100],
                      child: Text('$durationText / $totalText'),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _onVideo360ViewCreated(Video360Controller controller) {
    this.controller = controller;
    this.controller?.play();
  }
}
