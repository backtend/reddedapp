import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = List.generate(
      10,
      (index) => '视频 ${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('视频'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(Icons.play_circle),
              title: Text(videos[index]),
              subtitle: const Text('视频简介'),
            ),
          );
        },
      ),
    );
  }
}