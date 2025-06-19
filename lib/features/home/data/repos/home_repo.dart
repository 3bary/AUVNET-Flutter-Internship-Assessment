import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurant_model.dart';
import '../models/service_model.dart';

class HomeRepository {
  final FirebaseFirestore _firestore;

  HomeRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ServiceModel>> fetchServices() async {
    final snapshot = await _firestore.collection('services').get();
    return snapshot.docs
        .map((doc) => ServiceModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<RestaurantModel>> fetchPopularRestaurants() async {
    final snapshot = await _firestore
        .collection('restaurants')
        .where('isPopular', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((doc) => RestaurantModel.fromJson(doc.data()))
        .toList();
  }
}
