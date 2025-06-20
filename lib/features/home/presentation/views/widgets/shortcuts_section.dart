import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortcutsList extends StatelessWidget {
  final List<Map<String, dynamic>> shortcuts = [
    {
      'label': 'Past orders',
      'icon': Icons.receipt_long_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Super Saver',
      'icon': Icons.local_atm_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Must-tries',
      'icon': Icons.star_border_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Give Back',
      'icon': Icons.volunteer_activism_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Best Sellers',
      'icon': Icons.star_rounded,
      'color': Colors.deepPurple,
    },
  ];

  ShortcutsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: shortcuts.length,
        separatorBuilder: (context, _) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final item = shortcuts[index];

          return Column(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF2EF), // soft peach background
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Icon(item['icon'], color: item['color'], size: 28.sp),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                item['label'],
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
