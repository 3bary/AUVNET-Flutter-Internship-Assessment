class ServiceModel {
  final String id;
  final String title;
  final String imageUrl;
  final String subtitle;

  ServiceModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    title: json['title'],
    imageUrl: json['imageUrl'],
    subtitle: json['subtitle'],
  );
}
