import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/onboarding_data.dart';
import 'login_view.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_content.dart';
import 'widgets/onboarding_controls.dart';
import 'widgets/onboarding_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "all-in-one delivery",
      description:
          "Order groceries, medicines, and meals delivered straight to your door",
    ),
    OnboardingData(
      title: "User-to-User Delivery",
      description: "Send or receive items from other users quickly and easily",
    ),
    OnboardingData(
      title: "Sales & Discounts",
      description: "Discover exclusive sales and deals every day",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const OnboardingHeader(),
          SizedBox(height: 85.h),
          // Page View for onboarding content
          SizedBox(
            height: 114.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingContent(data: _onboardingData[index]);
              },
            ),
          ),
          SizedBox(height: 30.h),
          // Page indicator
          OnboardingPageIndicator(
            currentPage: _currentPage,
            pageCount: _onboardingData.length,
          ),
          SizedBox(height: 20.h),
          // Navigation controls
          OnboardingControls(
            currentPage: _currentPage,
            pageCount: _onboardingData.length,
            onNextPressed: _goToNextPage,
            onGetStartedPressed: _onGetStartedPressed,
            isLastPage: _currentPage == _onboardingData.length - 1,
          ),
        ],
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onGetStartedPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _goToNextPage();
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    // Handle onboarding completion
    // Navigate to main app screen
    print('Onboarding completed!');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
    // Example: Navigator.pushReplacementNamed(context, '/main');
  }
}
