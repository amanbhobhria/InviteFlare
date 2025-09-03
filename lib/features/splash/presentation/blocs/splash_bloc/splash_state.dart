part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashLoadingState extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashSuccessState extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashHomeState extends SplashState {
  @override
  List<Object> get props => [];
}
