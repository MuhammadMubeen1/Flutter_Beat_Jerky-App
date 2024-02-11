import 'dart:math';
import 'dart:ui';

import 'package:beat_jerky/services/api_services/video_services/video_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:video_player/video_player.dart';

class VideoScreenPage extends StatefulWidget {
  @override
  _VideoScreenPageState createState() => _VideoScreenPageState();
}

class _VideoScreenPageState extends State<VideoScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VideoScreen(),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   unselectedItemColor: Colors.white,
        //   backgroundColor: Colors.black,
        //   currentIndex: 0, // this will be set when a new tab is tapped
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: TtIcon(iconData: Icons.home, size: 36),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: TtIcon(iconData: Icons.search, size: 36),
        //       label: 'Discover',
        //     ),
        //     BottomNavigationBarItem(
        //         icon: TtIcon(iconData: Icons.add, size: 36),
        //         label: ''
        //     ),
        //     BottomNavigationBarItem(
        //       icon: TtIcon(iconData: Icons.message, size: 36),
        //       label: 'Inbox',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: TtIcon(iconData: Icons.account_circle, size: 36),
        //       label: 'Me',
        //     )
        //   ],
        // )
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  final videos = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4'
  ];

  getAllVideos()async{
    EasyLoading.show(status: 'Loading...');
    await VideoServices().getAllVideos(context);
    EasyLoading.dismiss();
    setState(() {

    });
  }


  @override
  void initState() {
    getAllVideos();
    _videoController =
        VideoPlayerController.network(videos[Random().nextInt(4)]);
    _initializeVideoPlayerFuture = _videoController!.initialize();
    _videoController!.play();
    _videoController!.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _videoController!.dispose();
    _videoController!.pause();
    super.dispose();
  }

  Widget _video(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return VideoPlayer(_videoController!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // Widget _top() {
  //   return Align(
  //     alignment: Alignment.topCenter,
  //     child: Container(
  //       padding: EdgeInsets.all(16.0),
  //       width: double.infinity,
  //       height: 50,
  //       color: Colors.transparent,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           TtText(text: 'Following', size: 18),
  //           VerticalDivider(
  //             color: Colors.white,
  //           ),
  //           TtText(
  //             text: 'For You',
  //             size: 18,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _right(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 60,
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Stack(
                children: [
                  CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1611575330633-551252bafad7?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=200&ixlib=rb-1.2.1&q=80&w=300')),
                  Positioned(
                    top: 40,
                    left: 17,
                    child: ClipOval(
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          splashColor: Colors.orange,
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 14,
                              )),
                          onTap: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(
                iconData: Icons.favorite,
                size: 36,
              ),
              onPressed: () {},
            ),
            TtText(text: '856', size: 18),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(iconData: Icons.comment, size: 36),
              onPressed: () {},
            ),
            TtText(text: '35', size: 18),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(iconData: Icons.send, size: 36),
              onPressed: () {},
            ),
            TtText(
              text: '1',
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottom() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 120,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Row(children: [
                    TtIcon(
                      iconData: Icons.shopping_cart,
                      size: 16,
                    ),
                    TtText(text: 'Shop', size: 18),
                  ]),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                TtText(text: '@account_name', size: 18),
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              ],
            ),
            SizedBox(height: 6),
            TtText(
                text: 'This is caption #hashtag #hashtag #hashtag', size: 13),
            SizedBox(height: 6),
            Row(
              children: [
                TtIcon(iconData: Icons.music_note, size: 14),
                TtText(text: 'Original Sound', size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _video(context),
        // _top(),
        _bottom(),
        _right(context),
      ],
    );
  }



}

class TtIcon extends StatelessWidget {
  final IconData? iconData;
  final double? size;

  const TtIcon({Key? key, this.iconData, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, size: this.size, color: Colors.white);
  }
}

class TtText extends StatelessWidget {
  final String text;
  final double size;

  const TtText({Key? key,required this.text,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: size));
  }
}