import 'package:auvnet_app/features/home/presentation/views/tabs/cart_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/categories_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/delivery_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/profile_view.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/coupon_card.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/header_widget.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/promo_banner.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/restaurants_section.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/services_section.dart';
import 'package:auvnet_app/features/home/presentation/views/widgets/shortcuts_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              HeaderWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),
                    _buildSectionTitle('Services:'),
                    ServicesSection(services: state.services),
                    SizedBox(height: 18.h),
                    const CouponCard(),
                    SizedBox(height: 14.h),
                    _buildSectionTitle('Shortcuts:'),
                    ShortcutsList(),
                    SizedBox(height: 24.h),
                    const Align(
                      alignment: Alignment.center,
                      child: PromoBanner(),
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle('Popular Restaurants Nearby:'),
                    RestaurantsSection(restaurants: state.restaurants),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: Colors.black87,
        ),
      ),
    );
  }
}
