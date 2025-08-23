# BLoC and Injectable Setup Guide

This project now uses **BLoC (Business Logic Component)** for state management and **Injectable** for dependency injection.

## 🏗️ Architecture Overview

The project follows a clean architecture pattern with:

- **BLoC** for state management
- **Injectable** for dependency injection
- **Equatable** for value equality comparisons

## 📁 Project Structure

```
lib/
├── di/
│   ├── injection.dart          # DI configuration
│   └── injection.config.dart   # Generated DI config
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       └── pages/
│   │           └── auth_page.dart
│   └── home/
│       └── presentation/
│           └── bloc/
│               ├── home_bloc.dart
│               ├── home_event.dart
│               └── home_state.dart
└── services/
    └── auth_service.dart       # Injectable service
```

**Note**: The home BLoC uses `part of` syntax where `home_event.dart` and `home_state.dart` are parts of `home_bloc.dart`.

## 🔧 How to Use

### 1. Creating a Service (Injectable)

```dart
import 'package:injectable/injectable.dart';

@injectable
class MyService {
  Future<void> doSomething() async {
    // Your logic here
  }
}
```

### 2. Creating a BLoC

**Option 1: Separate Files (Recommended for complex BLoCs)**

**Events** (`my_bloc_event.dart`):

```dart
import 'package:equatable/equatable.dart';

abstract class MyBlocEvent extends Equatable {
  const MyBlocEvent();

  @override
  List<Object?> get props => [];
}

class LoadData extends MyBlocEvent {}
class UpdateData extends MyBlocEvent {
  final String data;
  const UpdateData(this.data);

  @override
  List<Object?> get props => [data];
}
```

**States** (`my_bloc_state.dart`):

```dart
import 'package:equatable/equatable.dart';

abstract class MyBlocState extends Equatable {
  const MyBlocState();

  @override
  List<Object?> get props => [];
}

class MyBlocInitial extends MyBlocState {}
class MyBlocLoading extends MyBlocState {}
class MyBlocLoaded extends MyBlocState {
  final String data;
  const MyBlocLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
class MyBlocError extends MyBlocState {
  final String message;
  const MyBlocError(this.message);

  @override
  List<Object?> get props => [message];
}
```

**BLoC** (`my_bloc.dart`):

```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'my_bloc_event.dart';
import 'my_bloc_state.dart';

@injectable
class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
  MyBloc() : super(MyBlocInitial()) {
    on<LoadData>(_onLoadData);
    on<UpdateData>(_onUpdateData);
  }

  Future<void> _onLoadData(
    LoadData event,
    Emitter<MyBlocState> emit,
  ) async {
    emit(MyBlocLoading());
    try {
      // Your logic here
      emit(MyBlocLoaded('Data loaded'));
    } catch (e) {
      emit(MyBlocError('Error loading data'));
    }
  }

  Future<void> _onUpdateData(
    UpdateData event,
    Emitter<MyBlocState> emit,
  ) async {
    // Handle update logic
  }
}
```

### 3. Using BLoC in Widgets

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../di/injection.dart';
import '../bloc/my_bloc.dart';
import '../bloc/my_bloc_event.dart';
import '../bloc/my_bloc_state.dart';

@injectable
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyBloc>()..add(LoadData()),
      child: BlocBuilder<MyBloc, MyBlocState>(
        builder: (context, state) {
          if (state is MyBlocLoading) {
            return const CircularProgressIndicator();
          }

          if (state is MyBlocLoaded) {
            return Text(state.data);
          }

          if (state is MyBlocError) {
            return Text('Error: ${state.message}');
          }

          return const Text('Initial state');
        },
      ),
    );
  }
}
```

### 4. Listening to State Changes

```dart
BlocListener<MyBloc, MyBlocState>(
  listener: (context, state) {
    if (state is MyBlocError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: YourWidget(),
)
```

## 🔄 Code Generation

After adding new `@injectable` classes, run:

```bash
flutter packages pub run build_runner build
```

Or for continuous generation during development:

```bash
flutter packages pub run build_runner watch
```

## 📦 Dependencies Added

- `flutter_bloc: ^8.1.4` - Flutter BLoC widgets
- `bloc: ^8.1.3` - BLoC core library
- `equatable: ^2.0.5` - Value equality
- `injectable: ^2.3.2` - Dependency injection
- `get_it: ^7.6.7` - Service locator
- `injectable_generator: ^2.4.1` - Code generation
- `build_runner: ^2.4.8` - Build system
- `bloc_test: ^9.1.6` - BLoC testing

## 🚀 Getting Started

1. The dependency injection is already initialized in `main.dart`
2. All services and BLoCs are automatically registered
3. Use `getIt<YourClass>()` to get dependencies
4. Use `BlocProvider` to provide BLoCs to widgets
5. Use `BlocBuilder` to rebuild UI based on state changes
6. Use `BlocListener` to react to state changes (side effects)

## 🧪 Testing

You can test BLoCs using `bloc_test`:

```dart
import 'package:bloc_test/bloc_test.dart';

blocTest<MyBloc, MyBlocState>(
  'emits [MyBlocLoading, MyBlocLoaded] when LoadData is added',
  build: () => MyBloc(),
  act: (bloc) => bloc.add(LoadData()),
  expect: () => [
    MyBlocLoading(),
    MyBlocLoaded('Data loaded'),
  ],
);
```
