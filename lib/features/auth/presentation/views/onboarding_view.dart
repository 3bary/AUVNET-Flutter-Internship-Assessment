import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets.dart';
import '../../data/models/onboarding_data.dart';

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
          SizedBox(
            height: 427.h,
            child: Stack(
              children: [
                Positioned(
                  top: -20.h,
                  left: -104.w,
                  child: Container(
                    width: 342.w,
                    height: 342.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF8900FE), Color(0xFFFFDE59)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 91.h,
                  child: Image.asset(kAppLogo, width: 336.w, height: 336.h),
                ),
              ],
            ),
          ),
          SizedBox(height: 85.h),
          Column(
            children: [
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
                    return _buildOnboardingPage(_onboardingData[index]);
                  },
                ),
              ),
              SizedBox(height: 50.h),
              Stack(
                children: [
                  // circle shadow
                  Positioned(
                    bottom: -45.h,
                    right: -40.w,
                    child: Container(
                      width: 216.w,
                      height: 216.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF0EBE7E).withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: Offset(
                              0,
                              20,
                            ), // 👈 Optional: adds depth vertically
                            spreadRadius: 3, // 👈 Optional: makes shadow wider
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < _onboardingData.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                // Navigate to main app or complete onboarding
                                _completeOnboarding();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5CF6),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        // Next text
                        if (_currentPage < _onboardingData.length - 1)
                          TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'next',
                              style: TextStyle(
                                color: Color(0xFF677294),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
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
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: Column(
        children: [
          // Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 11.h),
          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF677294).withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    // Handle onboarding completion
    // Navigate to main app screen
    print('Onboarding completed!');
    // Example: Navigator.pushReplacementNamed(context, '/main');
  }
}
