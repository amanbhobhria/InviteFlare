// invitations_controller.dart
import 'package:get/get.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/features/invitations/domain/invitation.dart';

class InvitationsController extends GetxController {
  var isLoading = true.obs;
  var invitations = <Invitation>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInvitations();
  }

  void loadInvitations() async {
    try {
      isLoading(true);

      // Simulate a delay for fetching
      await Future.delayed(const Duration(seconds: 1));

      // Simulated data (replace with real API call)
      invitations.value = [
        Invitation(
          invitationId: "1",
          eventName: "Birthday Bash",
          hostName: "Alice",
          status: "Accepted",
          eventDate: DateTime.now().add(const Duration(days: 5)),
        ),
        Invitation(
          invitationId: "2",
          eventName: "Wedding Party",
          hostName: "Bob",
          status: "Pending",
          eventDate: DateTime.now().add(const Duration(days: 10)),
        ),
      ];

      errorMessage('');
    } catch (e) {
      errorMessage("Failed to load invitations");
    } finally {
      isLoading(false);
    }
  }

  void callInvitationListApi() async {
    try {
      DioClient dioClient = DioClient(Dio()); // ✅ No need to pass baseUrl

      await dioClient.get('api/v1/user/invitations',
          skipAuth: false, queryParameters: {'type': 'greeting'}).then((value) {
        if (value != null) {
          debugPrint("User Profile: ${jsonDecode(value)}");
        }
      }).onError(
        (error, stackTrace) {
          NetworkExceptions.getDioException(error);
          toast(NetworkExceptions.messageData);
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    callInvitationListApi();
  }
}
