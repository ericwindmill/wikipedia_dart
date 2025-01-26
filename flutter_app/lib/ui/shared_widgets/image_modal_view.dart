import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class ImageModalView extends StatelessWidget {
  const ImageModalView(this.image, {super.key});

  final WikipediaImage image;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: <Widget>[]),
    );
  }
}
