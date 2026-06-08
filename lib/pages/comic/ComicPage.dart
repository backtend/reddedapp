import 'package:flutter/material.dart';

class ComicPage extends StatelessWidget {
  const ComicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final comics = List.generate(
      12,
      (index) => '漫画 ${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('漫画'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: comics.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(comics[index]),
            ),
          );
        },
      ),
    );
  }
}