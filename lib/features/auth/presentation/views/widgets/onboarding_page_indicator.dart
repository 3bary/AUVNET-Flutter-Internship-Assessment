import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final double dotSize;
  final double activeDotSize;
  final double spacing;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
    this.dotSize = 8.0,
    this.activeDotSize = 10.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          width: index == currentPage ? activeDotSize.w : dotSize.w,
          height: index == currentPage ? activeDotSize.w : dotSize.w,
          margin: EdgeInsets.symmetric(horizontal: spacing.w / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage 
                ? const Color(0xFF8B5CF6) 
                : Colors.grey[300],
          ),
        );
      }),
    );
  }
}
