import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/features/category/data/repositories/repositories.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<FetchCategoryEvent>(getCategoryMethod);
  }

  FutureOr<void> getCategoryMethod(
      FetchCategoryEvent event,
      Emitter<CategoryState> emit,
      ) async {
    emit(CategoryLoadingState());
    try {
      final response = await _categoryRepository.getAllCategories();
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<CategoryEntity> data = CategoryEntity.listFromJson(jsonList);
      emit(CategorySuccessState(data));
    } catch (error) {
      emit(CategoryErrorState());
    }
  }
}
