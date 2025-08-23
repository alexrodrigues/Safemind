import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    // on<UserLocationRequestEvent>(_onRequestUserLocation,
    //     transformer: throttleDroppable(
    //       const Duration(milliseconds: 200),
    //     ));
    // on<SearchBuslineEvent>(_onSearchBusline,
    //     transformer: debounce(
    //       const Duration(milliseconds: 300),
    //     ));
    // on<BusPositionEvent>(_onBusesOnThisLine,
    //     transformer: throttleDroppable(
    //       const Duration(milliseconds: 1000),
    //     ));
    // on<GetRouteShapeEvent>(_onGetRouteShape,
    //     transformer: throttleDroppable(
    //       const Duration(milliseconds: 500),
    //     ));
  }
  // final GetUserLocationUseCase _useCase;
  // final SearchHomeBuslineUseCase _searchBuslineUseCase;
  // final GetBusPositionsUseCase _getBusPositionsUseCase;
  // final GetRouteShapeUseCase _getRouteShapeUseCase;
}
