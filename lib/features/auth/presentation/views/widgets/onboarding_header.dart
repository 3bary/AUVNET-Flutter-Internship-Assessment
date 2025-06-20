import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/assets.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
