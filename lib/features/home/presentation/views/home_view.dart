import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/restaurant_model.dart';
import '../../data/models/service_model.dart';
import '../view_model/home_bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(RepositoryProvider.of(context))..add(LoadHomeData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(LoadHomeData());
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildServices(context, state.services),
                    const SizedBox(height: 24),
                    _buildCouponCard(),
                    const SizedBox(height: 24),
                    _buildShortcuts(),
                    const SizedBox(height: 24),
                    _buildPromoBanner(),
                    const SizedBox(height: 24),
                    _buildPopularRestaurants(context, state.restaurants),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        },
      ),
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
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivering to", style: TextStyle(color: Colors.white70)),
                Text(
                  "Al Satwa, 81A Street",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Hi hepa!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              "assets/user.jpg",
            ), // replace with NetworkImage or your asset
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context, List<ServiceModel> services) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return SizedBox(
            width: 120,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getServiceIcon(service.title),
                      size: 32,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.discount as String,
                      style: const TextStyle(color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 12),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(
          Icons.confirmation_number,
          size: 32,
          color: Colors.deepPurple,
        ),
        title: Text(
          "Got a code?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Add your code and save on your order"),
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
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shortcuts.length,
        itemBuilder: (context, index) {
          final item = shortcuts[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepPurple[50],
                child: Icon(item['icon'] as IconData, color: Colors.deepPurple),
              ),
              SizedBox(height: 8),
              Text(item['label']!, style: TextStyle(fontSize: 12)),
            ],
          );
        },
        separatorBuilder: (_, _) => SizedBox(width: 16),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
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
        const Text(
          "Popular restaurants nearby",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return SizedBox(
                width: 100,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      backgroundImage: restaurant.logoUrl.isNotEmpty
                          ? NetworkImage(restaurant.logoUrl) as ImageProvider
                          : const AssetImage(
                              'assets/restaurant_placeholder.png',
                            ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant.name,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${restaurant.deliveryTimeMinutes} mins',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 16),
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
      items: [
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
