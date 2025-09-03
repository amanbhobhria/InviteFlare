import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'recent_search_event.dart';
part 'recent_search_state.dart';

@injectable
class RecentSearchBloc extends Bloc<RecentSearchEvent, RecentSearchState> {
  RecentSearchBloc() : super(RecentSearchInitial()) {
    on<GetRecentSearchEvent>(onGetRecentSearchEvent);
  }

  FutureOr<void> onGetRecentSearchEvent(
    GetRecentSearchEvent event,
    Emitter<RecentSearchState> emit,
  ) async {
    emit(RecentSearchLoading());
    emit(RecentSearchSuccess());
  }
}
