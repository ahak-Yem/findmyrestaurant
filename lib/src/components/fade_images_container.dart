import 'package:findmyrestaurant/src/components/loading_placeholder.dart';
import 'package:findmyrestaurant/src/controllers/fade_images_controller.dart';
import 'package:flutter/material.dart';

class FadeImagesContainer extends StatefulWidget {
  final String imagePath;
  final double heightPercentage;

  const FadeImagesContainer({
    super.key,
    required this.imagePath,
    required this.heightPercentage,
  });

  @override
  createState() => _FadeImagesContainerState();
}

class _FadeImagesContainerState extends State<FadeImagesContainer> with SingleTickerProviderStateMixin {
  late Map<String, bool> _imagePathExists;
  late FadeImagesController _controller;

  @override
  void initState() {
    super.initState();
    _imagePathExists = {widget.imagePath: false};
    _controller = FadeImagesController(this);
    _controller.startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FadeImagesContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_imagePathExists.containsKey(widget.imagePath) && widget.imagePath != oldWidget.imagePath) {
      _imagePathExists.addEntries([MapEntry(widget.imagePath, false)]);
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: LoadingPlaceholder()
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller.opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller.opacityAnimation.value,
                  child: child,
                );
              },
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                  if (_imagePathExists[widget.imagePath] == true) {
                    return child;
                  } else {
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        _imagePathExists[widget.imagePath] = true;
                      });
                    });
                    return child;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}