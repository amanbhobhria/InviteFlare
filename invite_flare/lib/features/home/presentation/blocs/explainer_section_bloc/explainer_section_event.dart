part of 'explainer_section_bloc.dart';

sealed class ExplainerSectionEvent extends Equatable {
  const ExplainerSectionEvent();
}

final class FetchExplainerSectionEvent extends ExplainerSectionEvent {
  @override
  List<Object?> get props => [];
}
