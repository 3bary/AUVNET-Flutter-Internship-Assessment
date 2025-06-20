import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile View',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
