import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/category/domain/domain.dart';
import 'package:invite_flare/shared/domain/entities/entities.dart';

part 'categories_event.dart';
part 'categories_state.dart';

@Injectable()
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesUseCase categoriesUseCase;

  CategoriesBloc({
    required this.categoriesUseCase,
  }) : super(CategoriesInitial()) {
    on<OnGetCategoriesEvent>(onGetCategoriesEvent);
  }

  FutureOr<void> onGetCategoriesEvent(
    OnGetCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    final categories =
        await categoriesUseCase(NoParams(categoryName: event.categoryName));
    emit(CategoriesSuccess(categories: categories));
  }
}
