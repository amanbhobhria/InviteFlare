import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_event.dart';
part 'main_state.dart';

@injectable
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainUpdatePageEvent>(updatePageMethod);
  }

  FutureOr<void> updatePageMethod(
    MainUpdatePageEvent event,
    Emitter<MainState> emit,
  ) {
    emit(MainLoadingState());
    emit(MainUpdateState(pageNo: event.pageNo));
  }
}
