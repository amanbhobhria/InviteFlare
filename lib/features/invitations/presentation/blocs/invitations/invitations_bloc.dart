import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/invitation.dart';

/// EVENTS
abstract class InvitationsEvent {}

class LoadInvitations extends InvitationsEvent {}

/// STATES
abstract class InvitationsState {}

class InvitationsInitial extends InvitationsState {}

class InvitationsLoading extends InvitationsState {}

class InvitationsLoaded extends InvitationsState {
  final List<Invitation> invitations;
  InvitationsLoaded(this.invitations);
}

class InvitationsError extends InvitationsState {
  final String message;
  InvitationsError(this.message);
}

/// BLOC
class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  InvitationsBloc() : super(InvitationsInitial()) {
    on<LoadInvitations>(_onLoadInvitations);
  }

  Future<void> _onLoadInvitations(
      LoadInvitations event, Emitter<InvitationsState> emit) async {
    emit(InvitationsLoading());
    await Future.delayed(const Duration(seconds: 1)); // simulate API

    // Static data for now
    final invitations = [
      Invitation(
        invitationId: "INV001",
        eventName: "Flutter Dev Meetup",
        hostName: "Tech Community",
        status: "Accepted",
        eventDate: DateTime(2025, 9, 10),
      ),
      Invitation(
        invitationId: "INV002",
        eventName: "Startup Pitch Night",
        hostName: "Angel Network",
        status: "Pending",
        eventDate: DateTime(2025, 9, 15),
      ),
      Invitation(
        invitationId: "INV003",
        eventName: "Wedding Ceremony",
        hostName: "John & Jane",
        status: "Declined",
        eventDate: DateTime(2025, 9, 20),
      ),
    ];

    emit(InvitationsLoaded(invitations));
  }
}
