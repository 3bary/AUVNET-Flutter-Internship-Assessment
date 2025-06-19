import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/restaurant_model.dart';
import '../../data/models/service_model.dart';
import '../../data/repos/home_repo.dart';
import '../view_model/home_bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(HomeRepository(firestore: FirebaseFirestore.instance))
            ..add(LoadHomeData()),
      child: const HomeViewContent(),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeData());
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildHeader(),
                  SizedBox(height: 16.h),
                  _buildServices(context, state.services),
                  SizedBox(height: 24.h),
                  _buildCouponCard(),
                  SizedBox(height: 24.h),
                  _buildShortcuts(),
                  SizedBox(height: 24.h),
                  _buildPromoBanner(),
                  SizedBox(height: 24.h),
                  _buildPopularRestaurants(context, state.restaurants),
                  SizedBox(height: 32.h),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.orangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to",
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                Text(
                  "Al Satwa, 81A Street",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Hi hepa!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage("assets/user.jpg"),
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context, List<ServiceModel> services) {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return SizedBox(
            width: 120.w,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getServiceIcon(service.title),
                      size: 32.sp,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${service.discount}",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
      ),
    );
  }

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'health & wellness':
        return Icons.health_and_safety;
      case 'groceries':
        return Icons.local_grocery_store;
      default:
        return Icons.category;
    }
  }

  Widget _buildCouponCard() {
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

  Widget _buildShortcuts() {
    final List<Map<String, dynamic>> shortcuts = [
      {'label': 'Past orders', 'icon': Icons.history},
      {'label': 'Super Saver', 'icon': Icons.local_offer},
      {'label': 'Must-tries', 'icon': Icons.star},
      {'label': 'Give Back', 'icon': Icons.volunteer_activism},
      {'label': 'Best Sellers', 'icon': Icons.thumb_up},
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shortcuts.length,
        itemBuilder: (context, index) {
          final item = shortcuts[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.deepPurple[50],
                child: Icon(item['icon'] as IconData, color: Colors.deepPurple),
              ),
              SizedBox(height: 8.h),
              Text(item['label']!, style: TextStyle(fontSize: 12.sp)),
            ],
          );
        },
        separatorBuilder: (_, _) => SizedBox(width: 16.w),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset('assets/krispy_kreme_banner.jpg', fit: BoxFit.cover),
    );
  }

  Widget _buildPopularRestaurants(
    BuildContext context,
    List<RestaurantModel> restaurants,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular restaurants nearby",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
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
                    Text(
                      '${restaurant.deliveryTimeMinutes} mins',
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(width: 16.w),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delivery_dining),
          label: "Deliver",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
