import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'article',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
