import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.noBoardingTitle1,
            AppStrings.noBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.noBoardingTitle2,
            AppStrings.noBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.noBoardingTitle3,
            AppStrings.noBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.noBoardingTitle4,
            AppStrings.noBoardingSubTitle4, ImageAssets.onBoardingLogo1),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          // return onboarding page
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                ),
              ),
            ),

            // widget indicator and arrows
            _getBottomSheetWidget()
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left arrow
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p14,
          ),
          child: GestureDetector(
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.leftArrowIc,
              ),
            ),
          ),
        ),

        // circle indicator
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p8,
                ),
                child: _getProperCircle(i),
              ),
          ],
        ),

        // right arrow
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p14,
          ),
          child: GestureDetector(
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.rightArrowIc,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(
        ImageAssets.hollowCircleIc,
      );
    } else {
      return SvgPicture.asset(
        ImageAssets.solidCircleIc,
      );
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p8,
          ),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p8,
          ),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(
          _sliderObject.image,
        ),
      ],
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
