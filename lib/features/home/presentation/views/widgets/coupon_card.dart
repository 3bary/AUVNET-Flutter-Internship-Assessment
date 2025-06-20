import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ListTile(
        leading: Icon(
          Icons.confirmation_number,
          size: 32.sp,
          color: Colors.deepPurple,
        ),
        title: Text(
          "Got a code?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        subtitle: Text(
          "Add your code and save on your order",
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
