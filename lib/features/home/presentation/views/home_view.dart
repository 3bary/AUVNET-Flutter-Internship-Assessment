import 'package:auvnet_app/features/home/presentation/views/tabs/cart_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/categories_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/delivery_view.dart';
import 'package:auvnet_app/features/home/presentation/views/tabs/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repo.dart';
import '../view_model/home_bloc/home_bloc.dart';
import 'tabs/home_view_body.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(HomeRepository(firestore: FirebaseFirestore.instance))
            ..add(LoadHomeData()),
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatefulWidget {
  const _HomeViewContent();

  @override
  State<_HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<_HomeViewContent> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeViewBody(),
    CategoriesView(),
    DeliveryView(),
    CartView(),
    ProfileView(),
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
