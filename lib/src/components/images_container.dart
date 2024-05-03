import 'package:flutter/material.dart';

class ImagesContainer extends StatefulWidget {
  final String imagePath;
  final double heightPercentage;

  const ImagesContainer({super.key, 
    required this.imagePath,
    required this.heightPercentage,
  });

  @override
  createState() => _ImagesContainerState();
}

class _ImagesContainerState extends State<ImagesContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
