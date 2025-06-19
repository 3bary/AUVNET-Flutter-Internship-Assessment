part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ServiceModel> services;
  final List<RestaurantModel> restaurants;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.services = const [],
    this.restaurants = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ServiceModel>? services,
    List<RestaurantModel>? restaurants,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      services: services ?? this.services,
      restaurants: restaurants ?? this.restaurants,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, services, restaurants, errorMessage];
}
