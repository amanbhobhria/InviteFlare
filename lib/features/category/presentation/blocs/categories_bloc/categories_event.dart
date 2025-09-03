part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

final class OnGetCategoriesEvent extends CategoriesEvent {
  final String categoryName;

  const OnGetCategoriesEvent({required this.categoryName});

  @override
  List<Object?> get props => [];
}
