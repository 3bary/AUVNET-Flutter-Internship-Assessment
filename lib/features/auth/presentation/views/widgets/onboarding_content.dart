import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/onboarding_data.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 11.h),
          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF677294).withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
