part of 'explainer_section_bloc.dart';

sealed class ExplainerSectionState extends Equatable {
  const ExplainerSectionState();
}

final class ExplainerSectionInitial extends ExplainerSectionState {
  @override
  List<Object> get props => [];
}

final class ExplainerSectionLoadingState extends ExplainerSectionState {
  @override
  List<Object> get props => [];
}

final class ExplainerSectionSuccessState extends ExplainerSectionState {
  final Map<String, dynamic> explainerSection;

  const ExplainerSectionSuccessState({required this.explainerSection});
  @override
  List<Object> get props => [explainerSection];
}

final class ExplainerSectionErrorState extends ExplainerSectionState {
  @override
  List<Object> get props => [];
}
