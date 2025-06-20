import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingControls extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final VoidCallback onNextPressed;
  final VoidCallback onGetStartedPressed;
  final bool isLastPage;

  const OnboardingControls({
    super.key,
    required this.currentPage,
    required this.pageCount,
    required this.onNextPressed,
    required this.onGetStartedPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Get Started Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
          child: SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: onGetStartedPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        // Next text (only show if not on last page)
        if (!isLastPage)
          TextButton(
            onPressed: onNextPressed,
            child: Text(
              'next',
              style: TextStyle(
                color: const Color(0xFF677294),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
