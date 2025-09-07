class Invitation {
  final String invitationId;
  final String eventName;
  final String hostName;
  final String status;
  final DateTime eventDate;

  Invitation({
    required this.invitationId,
    required this.eventName,
    required this.hostName,
    required this.status,
    required this.eventDate,
  });
}
