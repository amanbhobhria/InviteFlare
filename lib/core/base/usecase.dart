import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Equatable {
  final String categoryName;

  const NoParams({required this.categoryName});

  @override
  List<Object> get props => [];
}
