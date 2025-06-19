class ServiceModel {
  final String id;
  final String title;
  final String imageUrl;
  final String subtitle;

  final int discount;

  ServiceModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.discount,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    title: json['title'],
    imageUrl: json['imageUrl'],
    subtitle: json['subtitle'],
    discount: json['discount'],
  );
}
