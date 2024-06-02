import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
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
  late String _imagePlaceholder;
  late Map<String, bool> _imagePathExists;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _imagePlaceholder = ImagesReaderService.instance.getImagePath(
      ImagesPathsSections.extra,
      ImagesNames.loadingPlaceholder,
    );
    _imagePathExists = {widget.imagePath: false};

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();
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

  Widget loadingPlaceholderWidget() {
    return Positioned.fill(
      child: Image.asset(
        _imagePlaceholder,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
      child: Stack(
        children: [
          loadingPlaceholderWidget(),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
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