import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  _PromoBannerState createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _controller = PageController();
  final List<String> _images = [
    'assets/krispy_kreme_banner.jpg',
    'assets/krispy_kreme_banner.jpg',
    'assets/krispy_kreme_banner.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        SmoothPageIndicator(
          controller: _controller,
          count: _images.length,
          effect: WormEffect(
            activeDotColor: Colors.deepPurple,
            dotColor: Colors.grey.shade300,
            dotHeight: 8.r,
            dotWidth: 8.r,
            spacing: 8.r,
          ),
        ),
      ],
    );
  }
}
