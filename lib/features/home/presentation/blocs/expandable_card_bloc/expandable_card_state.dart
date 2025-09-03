part of 'expandable_card_bloc.dart';

sealed class ExpandableCardState extends Equatable {
  const ExpandableCardState();
}

final class ExpandableCardInitial extends ExpandableCardState {
  @override
  List<Object> get props => [];
}

final class ExpandableCardLoadingState extends ExpandableCardState {
  @override
  List<Object> get props => [];
}

final class ExpandableCardSuccessState extends ExpandableCardState {
  final Map<String, dynamic> expandableCard;

  const ExpandableCardSuccessState({required this.expandableCard});
  @override
  List<Object> get props => [expandableCard];
}

final class ExpandableCardErrorState extends ExpandableCardState {
  @override
  List<Object> get props => [];
}
