import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            _buildHeader(),
            SizedBox(height: 16),
            _buildServices(),
            SizedBox(height: 24),
            _buildCouponCard(),
            SizedBox(height: 24),
            _buildShortcuts(),
            SizedBox(height: 24),
            _buildPromoBanner(),
            SizedBox(height: 24),
            _buildPopularRestaurants(),
            SizedBox(height: 32),
          ],
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

  Widget _buildServices() {
    final List<Map<String, dynamic>> services = [
      {'title': 'Food', 'subtitle': 'Up to 50%', 'icon': Icons.fastfood},
      {
        'title': 'Health & wellness',
        'subtitle': '20 mins',
        'icon': Icons.health_and_safety,
      },
      {
        'title': 'Groceries',
        'subtitle': '15 mins',
        'icon': Icons.local_grocery_store,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: services.map((service) {
        return Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Icon(
                    service['icon'] as IconData,
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 8),
                  Text(
                    service['subtitle']!,
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  SizedBox(height: 4),
                  Text(
                    service['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
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
        separatorBuilder: (_, __) => SizedBox(width: 16),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset('assets/krispy_kreme_banner.jpg', fit: BoxFit.cover),
    );
  }

  Widget _buildPopularRestaurants() {
    final restaurants = [
      {'name': 'Allo Beirut', 'time': '32 mins'},
      {'name': 'Laffah', 'time': '38 mins'},
      {'name': 'Falafil Al Rabiah', 'time': '44 mins'},
      {'name': 'Barbar', 'time': '34 mins'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular restaurants nearby",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final r = restaurants[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assets/restaurant_${index + 1}.png',
                    ), // replace with actual assets
                  ),
                  SizedBox(height: 4),
                  Text(r['name']!, style: TextStyle(fontSize: 12)),
                  Text(
                    r['time']!,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 16),
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
