import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ScreenRoutes/routes.dart';
import '../../helper/appimage.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  initState() {
    loginStatus();
    super.initState();
  }

  Future<void> loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding', true);
  }

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      image2: AppImages.slideOneImage,
      title1: 'Welcome to Kodago Business',
      title2: 'Your Beauty, Your Way',
      title3:
          "Kodago Business: Transform your beauty routine with expert makeup artists and Business, for last-minute touch-ups or luxurious diva-worthy experiences.",
    ),
    OnboardingData(
      image2: AppImages.slideTwoImage,
      title1: 'Find Your Perfect Look',
      title2: 'Expert Makeup Artists at Your Fingertips',
      title3:
          "Explore expert makeup artists for your unique style at Kodago Business.",
    ),
    OnboardingData(
      image2: AppImages.slideThreeImage,
      title1: 'Discover Top Business',
      title2: 'Your Go-To Beauty Destinations',
      title3:
          "Discover top Business, hair, and skincare services with Kodago Business. Schedule hassle-free beauty appointments, read reviews, and book services effortlessly.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      //color set to transperent or set your own color
    ));*/
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Align(
              alignment: Alignment.topCenter,
              //height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: OnboardingPage(
                      data: _onboardingData[index],
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('initScreen', true);
                        Get.offAllNamed(AppRoutes.loginScreen);
                      },
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, bottom: 25),
                          child: getText(
                            size: 13,
                            color: ColorConstant.greyColor,
                            letterSpacing: 0.5,
                            fontFamily: celiaRegular,
                            fontWeight: FontWeight.w500,
                            title: _currentPage == _onboardingData.length - 1
                                ? ""
                                : 'Skip',
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        setState(() {});
                        if (_currentPage == _onboardingData.length - 1) {
                          Get.offAllNamed(AppRoutes.loginScreen);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('initScreen', true);
                        } else {
                          _pageController.jumpToPage(_currentPage + 1);
                        }
                        /*  _currentPage == _onboardingData.length - 1
                            ? Get.offAllNamed(AppRoutes.selectCreateAccount)
                            : _pageController.jumpToPage(_currentPage + 1);*/
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: _currentPage == _onboardingData.length - 1
                              ? EdgeInsets.only(bottom: 25)
                              : EdgeInsets.only(bottom: 15),
                          child: getText(
                            size: 13,
                            letterSpacing: 1,
                            color: ColorConstant.onBoardingBack,
                            fontFamily: celiaRegular,
                            fontWeight: FontWeight.w500,
                            title: _currentPage == _onboardingData.length - 1
                                ? "Get Started"
                                : 'Next',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _onboardingData.length; i++) {
      indicators.add(
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              height: 10.0,
              width: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == i
                    ? ColorConstant.onBoardingBack
                    : ColorConstant.dot,
              ),
            ),
          ],
        ),
      );
    }
    return indicators;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String image2;
  final String title1;
  final String title2;
  final String title3;

  OnboardingData({
    required this.image2,
    required this.title1,
    required this.title2,
    required this.title3,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: data.title1,
                      size: 20,
                      fontFamily: celiaRegular,
                      color: ColorConstant.onBoardingBack,
                      fontWeight: FontWeight.w600),
                  const SizedBox(
                    height: 5,
                  ),
                  getText(
                      title: data.title2,
                      size: 18,
                      fontFamily: celiaBold,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: getText(
                        title: data.title3,
                        size: 13,
                        fontFamily: celiaRegular,
                        color: ColorConstant.splashTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  data.image2,
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
