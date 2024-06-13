import 'package:flutter/material.dart';
import 'package:Lostify/backend/CRUD/fetcher.dart';
import 'package:Lostify/components/new_post_floating_action_button.dart';
// import 'package:Lostify/components/app_bar.dart';

class YourPostsPage extends StatefulWidget {
  const YourPostsPage({super.key});

  @override
  State<YourPostsPage> createState() => _YourPostsPageState();
}

class _YourPostsPageState extends State<YourPostsPage> {
  final GlobalKey _fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar('Your Requests', userImageExample),
      body: const Center(
        child: GetYourPosts(),
      ),
      floatingActionButton: NewPostFloatingActionButton(fabKey: _fabKey),
    );
  }
}
