import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:flutter/material.dart';

class ImagesContainer extends StatefulWidget {
  final String imagePath;
  final double heightPercentage;

  const ImagesContainer({
    super.key,
    required this.imagePath,
    required this.heightPercentage,
  });

  @override
  createState() => _ImagesContainerState();
}

class _ImagesContainerState extends State<ImagesContainer> {
  bool _isLoaded = false;
  late String _imagePlaceholder;

  set isLoaded(bool isLoaded) {
    setState(() {
      _isLoaded = isLoaded;
    });
  }

  @override
  void initState() {
    super.initState();
    _imagePlaceholder = ImagesReaderService.instance.getImagePath(
      ImagesPathsSections.extra,
      ImagesNames.loadingPlaceholder,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.heightPercentage / 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _imagePlaceholder,
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _isLoaded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 3000),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    Future.delayed(Duration.zero, () {
                      setState(() {
                        _isLoaded = true;
                      });
                    });
                    return child;
                  } else {
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
