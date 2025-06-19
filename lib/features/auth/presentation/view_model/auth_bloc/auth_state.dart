part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final String? userId;
  final bool isEmailVerified;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userId,
    this.isEmailVerified = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? userId,
    bool? isEmailVerified,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      userId: userId ?? this.userId,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userId, isEmailVerified];
}
