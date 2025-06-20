import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryView extends StatelessWidget {
  const DeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Delivery View',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
