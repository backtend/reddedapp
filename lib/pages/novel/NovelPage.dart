import 'package:flutter/material.dart';

class NovelPage extends StatelessWidget {
  const NovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final novels = List.generate(
      20,
      (index) => '小说 ${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('小说'),
      ),
      body: ListView.separated(
        itemCount: novels.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.book),
            title: Text(novels[index]),
            subtitle: const Text('作者：未知'),
          );
        },
      ),
    );
  }
}