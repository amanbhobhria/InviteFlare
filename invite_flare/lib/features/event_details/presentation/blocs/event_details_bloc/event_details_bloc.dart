import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/network/api_handler.dart';
import 'package:invite_flare/features/category/constants.dart';
import 'package:invite_flare/features/event_details/event_details.dart';
import 'package:invite_flare/shared/domain/entities/guest_entity.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';

@injectable
class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final EventDetailsUseCase eventDetailsUseCase;
  TextEditingController cEventTitle = TextEditingController();
  TextEditingController cHostedBy = TextEditingController();
  TextEditingController cEventDateTime = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  TextEditingController cCustomInviteMessage = TextEditingController();
  TextEditingController cLocation = TextEditingController();
  TextEditingController cVirtualLocation = TextEditingController();
  TextEditingController cDescription = TextEditingController();
  TextEditingController cRSVPDeadline = TextEditingController();
  TextEditingController cSchedule = TextEditingController();
  TextEditingController cGuestLimit = TextEditingController();
  TextEditingController cGuestName = TextEditingController();
  TextEditingController cGuestEmail = TextEditingController();
  bool needVirtualLocation = false;
  bool needAddConfetti = false;
  bool needRSVPCollect = false;
  bool needSendReminder = false;
  int currentIndex = 0;
  String allowToBringAdditionalGuests = 'No';

  final List<String> items = ['Yes', 'No'];
  final List<GuestEntity> guests = [];
  EventDetailsBloc({required this.eventDetailsUseCase})
      : super(EventDetailsLoadingState()) {
    on<EventDetailsSwitchEvent>(onEventDetailsSwitchEvent);
    on<EventDetailsChangeTabEvent>(onEventDetailsChangeTabEvent);
    on<AllowToBringAdditionalGuestEvent>(onAllowToBringAdditionalGuestEvent);
    on<OnAddGuestEvent>(onAddGuestEvent);
    on<OnRemoveGuestEvent>(onRemoveGuestEvent);
    on<SubmitEventInfoEvent>(_onSubmitEventInfoEvent);
    on<SubmitGuestInfoEvent>(_onSubmitGuestInfoEvent);
  }

  FutureOr<void> onEventDetailsSwitchEvent(
      EventDetailsSwitchEvent event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    switch (event.switchAction) {
      case SwitchAction.virtualLocation:
        needVirtualLocation = !needVirtualLocation;
        break;
      case SwitchAction.addConfetti:
        needAddConfetti = !needAddConfetti;
        break;
      case SwitchAction.rsvpCollect:
        needRSVPCollect = !needRSVPCollect;
        break;
      case SwitchAction.sendReminder:
        needSendReminder = !needSendReminder;
        break;
    }
    emit(EventDetailsRefreshState());
  }

  FutureOr<void> onEventDetailsChangeTabEvent(
      EventDetailsChangeTabEvent event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    if (currentIndex < 2) {
      currentIndex = event.index;
    }
    if (currentIndex > 0) {
      currentIndex = event.index;
    }
    emit(EventDetailsRefreshState());
  }

  FutureOr<void> onAllowToBringAdditionalGuestEvent(
      AllowToBringAdditionalGuestEvent event,
      Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    allowToBringAdditionalGuests = event.value;
    emit(EventDetailsRefreshState());
  }

  FutureOr<void> onAddGuestEvent(
    OnAddGuestEvent event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(EventDetailsLoadingState());
    guests.add(event.guest);
    cGuestName.clear();
    cGuestEmail.clear();
    emit(EventDetailsRefreshState());
  }

  FutureOr<void> onRemoveGuestEvent(
      OnRemoveGuestEvent event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    guests.remove(event.guest);
    emit(EventDetailsRefreshState());
  }

  Future<void> _onSubmitEventInfoEvent(
      SubmitEventInfoEvent event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    final response = await _submitEventInfo(event.cId);
    if (response.statusCode == 201) {
      emit(EventDetailsSubmitSuccess());
    } else {
      emit(EventDetailsSubmitFailure());
    }
  }

  Future<void> _onSubmitGuestInfoEvent(
      SubmitGuestInfoEvent event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoadingState());
    final response = await _submitGuestInfo(event.cId);
    if (response.statusCode == 201) {
      emit(GuestInfoSubmitSuccess());
    } else {
      emit(EventDetailsSubmitFailure());
    }
  }

  Future<Response> _submitEventInfo(String cId) async {
    try {
      var data = {
        "cId": cId,
        "event_title": cEventTitle.text,
        "event_datetime": DateFormat('yyyy-MM-dd HH:mm:ss').format(
          DateFormat('dd MMM yyyy, hh:mm a').parse(cEventDateTime.text),
        ),
        "event_hosted_by": cHostedBy.text,
        "is_virtual": needVirtualLocation ? 1 : 0,
        "event_address": cAddress.text,
        "location_name":
            cLocation.text.isEmpty ? null : cLocation.text, // Optional
        "virtual_event_link":
            cVirtualLocation.text.isEmpty ? null : cVirtualLocation.text,
        "description": cDescription.text,
        "collect_rsvp": needRSVPCollect ? 1 : 0,
        "confetti": needAddConfetti ? 1 : 0,
        "rsvp_deadline": cRSVPDeadline.text.isNotEmpty
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(
                DateFormat('dd MMM yyyy').parse(cRSVPDeadline.text),
              )
            : null,
        "allow_additional_guest": allowToBringAdditionalGuests == 'Yes' ? 1 : 0,
        "guest_limit": allowToBringAdditionalGuests == 'Yes'
            ? int.tryParse(cGuestLimit.text) ?? 2
            : null,
        "gift_registry": [], // You should define this list if needed
        "custom_invitation_message": cCustomInviteMessage.text,
        "send_reminders": needSendReminder ? 1 : 0,
        "reminder_schedule": '1 day before',
        "custom_reminder_date": null,
        "schedule_at": cSchedule.text.isNotEmpty
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(
                DateFormat('dd MMM yyyy, hh:mm a').parse(cSchedule.text),
              )
            : null,
      };

      final response = await _apiHandler.post(Constants.updateEventInfo,
          body: data, headers: {'Accept': 'application/json'});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _submitGuestInfo(String cId) async {
    try {
      final guestList = guests
          .map((guest) => {"name": guest.name, "email": guest.email})
          .toList();

      final data = {"cId": cId, "guests": guestList};

      final response = await _apiHandler.post(
        Constants.updateGuestInfo,
        body: data,
        headers: {'Accept': 'application/json'},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  final APIHandler _apiHandler = APIHandler();
}
