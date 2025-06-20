import 'package:auvnet_app/features/home/presentation/views/tabs/cart_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/categories_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/delivery_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/profile_view.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/promo_banner.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/service_card.dart';
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

class HomeViewContent extends StatefulWidget {
  const HomeViewContent({super.key});

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeScreen(),
    const CategoriesView(),
    const DeliveryView(),
    const CartView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
            children: [
              _buildHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),
                    _buildSectionTitle("Services:"),
                    SizedBox(height: 18.h),
                    _buildServices(context, state.services),
                    SizedBox(height: 18.h),
                    _buildCouponCard(),
                    SizedBox(height: 14.h),
                    _buildSectionTitle("Shortcuts:"),
                    SizedBox(height: 20.h),
                    _buildShortcuts(),
                    SizedBox(height: 24.h),
                    const Align(
                      alignment: Alignment.center,
                      child: PromoBanner(),
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle("Popular restaurants nearby:"),
                    _buildPopularRestaurants(context, state.restaurants),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
        ),
      ),
      padding: EdgeInsets.all(35.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
                Text(
                  "Al Satwa, 81A Street",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Hi hepa!",
                  style: TextStyle(
                    fontSize: 30.sp,
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
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(service: service);
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

  Widget _buildPopularRestaurants(
    BuildContext context,
    List<RestaurantModel> restaurants,
  ) {
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
    );
  }
}
