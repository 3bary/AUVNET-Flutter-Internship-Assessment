import 'package:auvnet_app/features/home/data/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantsSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantsSection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.white,
                      backgroundImage: restaurant.logoUrl.isNotEmpty
                          ? NetworkImage(restaurant.logoUrl)
                          : const AssetImage(
                                  'assets/restaurant_placeholder.png',
                                )
                                as ImageProvider,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      restaurant.name,
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 10.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${restaurant.deliveryTimeMinutes} mins',
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }
}
