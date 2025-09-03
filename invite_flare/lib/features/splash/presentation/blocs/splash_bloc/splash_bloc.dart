import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/services/token_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FetchDataEvent>(fetchInitialData);
  }

  FutureOr<void> fetchInitialData(
    FetchDataEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoadingState());
    final tokenService = TokenService();
    await Future.delayed(const Duration(seconds: 3), () {});
    if (await tokenService.isLoggedIn()) {
      emit(SplashHomeState());
    } else {
      emit(SplashSuccessState());
    }
  }
}
