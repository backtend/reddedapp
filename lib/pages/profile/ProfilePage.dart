import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 30),

          CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),

          SizedBox(height: 12),

          Center(
            child: Text(
              '用户名',
              style: TextStyle(fontSize: 18),
            ),
          ),

          SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('我的收藏'),
          ),

          ListTile(
            leading: Icon(Icons.history),
            title: Text('观看记录'),
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          ),
        ],
      ),
    );
  }
}