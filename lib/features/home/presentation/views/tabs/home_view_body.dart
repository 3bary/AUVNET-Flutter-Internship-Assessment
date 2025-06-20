import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/home_bloc/home_bloc.dart';
import '../widgets/coupon_card.dart';
import '../widgets/header_widget.dart';
import '../widgets/promo_banner.dart';
import '../widgets/restaurants_section.dart';
import '../widgets/services_section.dart';
import '../widgets/shortcuts_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
                    const SizedBox(height: 8),
                    _buildSectionTitle('Services:'),
                    ServicesSection(services: state.services),
                    const SizedBox(height: 16),
                    const CouponCard(),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Shortcuts:'),
                    ShortcutsList(),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.center,
                      child: PromoBanner(),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Popular Restaurants Nearby:'),
                    RestaurantsSection(restaurants: state.restaurants),
                    const SizedBox(height: 24),
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
