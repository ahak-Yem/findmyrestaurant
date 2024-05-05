import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findmyrestaurant/src/components/images_container.dart';
import 'package:findmyrestaurant/src/viewmodels/onboarding/onboarding_viewmodel.dart';
import 'package:findmyrestaurant/src/components/app_carousel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OnboardingViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDesignImage(),
            _buildCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignImage() {
    return Consumer<OnboardingViewModel>(
      builder: (context, viewModel, _) {
        if(viewModel.designImagePath.isNotEmpty && viewModel.designImagePath != ""){
          return ImagesContainer(
            imagePath: viewModel.designImagePath, 
            heightPercentage: 45,
          );
        }
        return const SizedBox(height: 0, width: 0,);
      },
    );
  }

  Widget _buildCarousel() {
    return Consumer<OnboardingViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.carouselItems.isNotEmpty && viewModel.carouselItems != []) {
          return AppCarousel(
            items: viewModel.carouselItems,
            heightPercentage: 55,
            onPageChanged: (index) {
              viewModel.onAppCarouselItemChanged(index);
            },
          );
        } else {
          return const SizedBox(height: 0, width: 0);
        }
      },
    );
  }
}
