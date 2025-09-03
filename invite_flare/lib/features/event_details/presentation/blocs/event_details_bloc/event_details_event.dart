part of 'event_details_bloc.dart';

enum SwitchAction { virtualLocation, addConfetti, rsvpCollect, sendReminder }

sealed class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();
}

final class SubmitEventInfoEvent extends EventDetailsEvent {
  final String cId;
  const SubmitEventInfoEvent(this.cId);

  @override
  List<Object?> get props => [cId];
}

final class SubmitGuestInfoEvent extends EventDetailsEvent {
  final String cId;
  const SubmitGuestInfoEvent(this.cId);

  @override
  List<Object?> get props => [cId];
}

final class EventDetailsSwitchEvent extends EventDetailsEvent {
  final SwitchAction switchAction;
  const EventDetailsSwitchEvent({required this.switchAction});

  @override
  List<Object?> get props => [];
}

final class EventDetailsChangeTabEvent extends EventDetailsEvent {
  final int index;
  const EventDetailsChangeTabEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

final class AllowToBringAdditionalGuestEvent extends EventDetailsEvent {
  final String value;
  const AllowToBringAdditionalGuestEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

final class OnAddGuestEvent extends EventDetailsEvent {
  final GuestEntity guest;
  const OnAddGuestEvent({required this.guest});

  @override
  List<Object?> get props => [guest];
}

final class OnRemoveGuestEvent extends EventDetailsEvent {
  final GuestEntity guest;
  const OnRemoveGuestEvent({required this.guest});

  @override
  List<Object?> get props => [guest];
}
