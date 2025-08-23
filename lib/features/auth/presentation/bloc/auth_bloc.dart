import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);

    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    });
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Sign in failed'));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.createUserWithEmailAndPassword(
        event.email,
        event.password,
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Sign up failed'));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
    } catch (e) {
      emit(AuthError('Sign out failed'));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = _authService.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }
}
