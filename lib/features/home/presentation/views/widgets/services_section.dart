import 'package:auvnet_app/features/home/data/models/service_model.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesSection extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.h),
        Container(
          height: 180.h,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 120.w,
                  minWidth: 120.w,
                ),
                child: ServiceCard(service: service, onTap: () {}),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}
