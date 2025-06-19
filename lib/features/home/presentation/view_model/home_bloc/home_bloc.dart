import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/restaurant_model.dart';
import '../../../data/models/service_model.dart';
import '../../../data/repos/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final services = await _repository.fetchServices();
      final restaurants = await _repository.fetchPopularRestaurants();

      if (services.isEmpty && restaurants.isEmpty) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: 'No data available',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: HomeStatus.success,
          services: services,
          restaurants: restaurants,
          errorMessage: null,
        ),
      );
    } catch (e) {
      // Provide a user-friendly error message
      String errorMessage = 'Failed to load data';
      if (e is FirebaseException) {
        errorMessage = 'Network error. Please check your connection.';
      } else if (e is FormatException) {
        errorMessage = 'Data format error. Please try again later.';
      }

      emit(
        state.copyWith(status: HomeStatus.failure, errorMessage: errorMessage),
      );
    }
  }
}
