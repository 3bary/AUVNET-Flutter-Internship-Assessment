class RestaurantModel {
  final String id;
  final String name;
  final String logoUrl;
  final int deliveryTimeMinutes;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.deliveryTimeMinutes,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        logoUrl: json['logoUrl'],
        deliveryTimeMinutes: json['deliveryTimeMinutes'],
      );
}
