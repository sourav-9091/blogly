import 'package:blog_firebase/features/blog/presentation/pages/new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blogly'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                NewBlogPage.route(),
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          )
        ],
      ),
    );
  }
}
