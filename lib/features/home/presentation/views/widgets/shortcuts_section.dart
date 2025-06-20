import 'package:flutter/material.dart';

class ShortcutsList extends StatelessWidget {
  final List<Map<String, dynamic>> shortcuts = [
    {
      'label': 'Past orders',
      'icon': Icons.receipt_long_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Super Saver',
      'icon': Icons.local_atm_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Must-tries',
      'icon': Icons.star_border_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Give Back',
      'icon': Icons.volunteer_activism_rounded,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Best Sellers',
      'icon': Icons.star_rounded,
      'color': Colors.deepPurple,
    },
  ];

  ShortcutsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: shortcuts.length,
        separatorBuilder: (context, _) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = shortcuts[index];

          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF2EF), // soft peach background
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(item['icon'], color: item['color'], size: 28),
                ),
              ),
              SizedBox(height: 6),
              Text(
                item['label'],
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
