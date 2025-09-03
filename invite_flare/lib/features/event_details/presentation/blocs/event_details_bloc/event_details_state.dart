part of 'event_details_bloc.dart';

sealed class EventDetailsState extends Equatable {
  const EventDetailsState();
}

final class EventDetailsLoadingState extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class EventDetailsRefreshState extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class EventDetailsSubmitSuccess extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class EventDetailsSubmitFailure extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class GuestInfoSubmitSuccess extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class GuestInfoSubmitFailure extends EventDetailsState {
  @override
  List<Object> get props => [];
}
