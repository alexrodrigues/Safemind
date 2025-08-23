import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final data = [
        'Welcome to SafeMind',
        'Your mental health companion',
        'Find the right therapist for you',
      ];

      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError('Failed to load home data'));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final data = [
        'Welcome to SafeMind',
        'Your mental health companion',
        'Find the right therapist for you',
        'Updated: ${DateTime.now().toString()}',
      ];

      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError('Failed to refresh home data'));
    }
  }
}
