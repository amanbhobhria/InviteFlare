import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/export.dart';

class ShareWithRsvpController extends GetxController {
  var isVirtual = false.obs;
  var isConfetti = false.obs;

  var gifts = <Map<String, String>>[].obs;
  RxInt selectIndex = 1.obs;
  final isLoading = false.obs;

  var cId = '';
  final eventTitle = TextEditingController();
  final hostedBy = TextEditingController();
  final eventDateTime = TextEditingController();
  final address = TextEditingController();
  final location = TextEditingController();
  final virtualLink = TextEditingController();
  final description = TextEditingController();
  final customINvitation = TextEditingController();

  // RSVP
  var isRsvpEnabled = false.obs;
  var isSendReminder = false.obs;
  var rsvpDeadline = ''.obs;
  var allowGuests = 'No'.obs;
  var customInvitation = ''.obs;
  var scheduleDate = ''.obs;
  var reminderType = '1 day before'.obs;
  var customReminderDate = ''.obs;

  /// Third Widget
  final guestNameController = TextEditingController();
  final guestEmailController = TextEditingController();
  final bulkEmailController = TextEditingController();
  final addedGuests = <String>[].obs; // List of added guest emails


  final isEmailRequired = false.obs;

  bool _isValidEmail(String email) => GetUtils.isEmail(email);

  // Add a single guest
  void addSingleGuest() {
    final email = guestEmailController.text.trim();

    if (email.isEmpty) {
      isEmailRequired.value = true;
      return;
    }

    if (!_isValidEmail(email)) {
      // Could show a snackbar or update a specific error message here
      isEmailRequired.value = true;
      Get.snackbar('Error', 'Please enter a valid email address.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // Clear any previous error state
    isEmailRequired.value = false;

    // Check for premium limit (hardcoded logic)
    if (addedGuests.length >= 30) {
      Get.snackbar('Limit Reached',
          'Free users can add up to 30 guests. Upgrade to invite more.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    if (!addedGuests.contains(email)) {
      addedGuests.add(email);
      guestNameController.clear();
      guestEmailController.clear();
    } else {
      Get.snackbar('Duplicate', 'This email is already in the list.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow.shade700,
          colorText: Colors.black);
    }
  }

  // Remove a guest
  void removeGuest(String email) {
    addedGuests.remove(email);
  }

  // Logic to handle bulk upload (Not fully implemented in UI, but ready in controller)
  void bulkUploadEmails() {
    // Logic for parsing and adding emails from bulkEmailController.text
    // Not implemented for brevity, but this is where you'd put it.
    Get.snackbar(
        'Bulk Upload', 'Bulk upload functionality can be implemented here!',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onInit() {
    super.onInit();
    print('CID!!! in arguments = ${Get.arguments} ');
    if (Get.arguments != null && Get.arguments['cId'] != null) {
      cId = Get.arguments['cId'];
      print('CID in arguments = $cId ');
    }
  }

  Future<void> hitAddEventInfoApi() async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        'cId': cId,
        'event_title': eventTitle.text.trim(),
        'event_datetime': _formatDate(eventDateTime.text.trim()),
        'event_hosted_by': hostedBy.text.trim(),
        'is_virtual': isVirtual.value ? 1 : 0,
        'event_address': isVirtual.value ? '' : address.text.trim(),
        'location_name': location.text.trim(),
        'virtual_event_link': isVirtual.value ? address.text.trim() : '',
        'description': description.text.trim(),
        'collect_rsvp': isRsvpEnabled.value ? 1 : 0,
        'confetti': isConfetti.value ? 1 : 0,
        'rsvp_deadline': _formatDate(rsvpDeadline.value),
        'allow_additional_guest': allowGuests.value == "Yes" ? 1 : 0,
        'guest_limit': addedGuests.length,
        'gift_registry': gifts.map((gift) => {
            'title': gift['title'] ?? '',
            'url': gift['url'] ?? '',
          }).toList(),
        'custom_invitation_message': customInvitation.value.isNotEmpty
            ? customInvitation.value
            : customINvitation.text.trim(),
        'send_reminders': isSendReminder.value ? 1 : 0,
        'reminder_schedule': reminderType.value,
        'custom_reminder_date': _formatDate(customReminderDate.value),
        'schedule_at': _formatDate(scheduleDate.value),
      };

      dev.log('📤 Final Dynamic Request Body: $body');

      var token = await TokenService().getAccessToken();

      final url = Uri.parse(
        "https://dev.inviteflare.com/api/v1/invitations/user/eventinfo",
      );

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      dev.log('✅ API Response Code: ${response.statusCode}');
      dev.log('✅ API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Event Info submitted successfully!');
      } else {
        final errorMsg =
            jsonDecode(response.body)['message'] ?? 'Unknown error occurred';
        Get.snackbar('Error', errorMsg);
      }
    } catch (e, st) {
      dev.log('❌ API Error: $e\n$st');
      Get.snackbar('Error', 'Failed to submit event info. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }






  //
  // Future<void> hitAddEventInfoApi() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final Map<String, dynamic> body = {
  //       'cId': 'dXmmIn2_9pci',
  //       "event_title": " Happyyyy Birthday",
  //       "event_datetime": "2025-11-09 00:00:00",
  //       "event_hosted_by": "AMan Narula",
  //       "is_virtual": 0,
  //       "event_address": "47 Elysian Fields Circle",
  //       "location_name": "John Apartment",
  //       "virtual_event_link": "",
  //       "description": "Lorem Ipsum 2",
  //       "collect_rsvp": 1,
  //       "confetti": 0,
  //       "rsvp_deadline": "2025-11-08 00:00:00",
  //       "allow_additional_guest": 0,
  //       "guest_limit": 1,
  //       "gift_registry": [
  //         {"title": "Amazon", "url": "https://amazon.com/registry"},
  //         {"title": "Walmart", "url": "https://walmart.com/registry"},
  //         {"title": "ebay", "url": "https://ebay.com/registry"}
  //       ],
  //       "custom_invitation_message": "Please join us on our special moment!",
  //       "send_reminders": 1,
  //       "reminder_schedule": "1 day before",
  //       "custom_reminder_date": "",
  //       "schedule_at": ""
  //     };
  //
  //     dev.log('📤 Final Request Body: $body');
  //
  //     var token = await TokenService().getAccessToken();
  //
  //     final url = Uri.parse(
  //         "https://dev.inviteflare.com/api/v1/invitations/user/eventinfo");
  //
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(body),
  //     );
  //
  //
  //     dev.log('✅ API Response!!! Code: ${response.statusCode}');
  //     dev.log('✅ API Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Get.snackbar('Success', 'Event Info submitted successfully!');
  //     } else {
  //       final errorMsg =
  //           jsonDecode(response.body)['message'] ?? 'Unknown error';
  //       Get.snackbar('Error', errorMsg);
  //     }
  //   } catch (e, st) {
  //     dev.log('❌ hitAddEventInfoApi with http error: $e\n$st');
  //     Get.snackbar('Error', 'Failed to submit event info. Please try again.');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



  // Date format helper (already present)
  String? _formatDate(String? input) {
    if (input == null || input.isEmpty) return null;
    try {
      final parsed = DateFormat('dd-MM-yyyy HH:mm').parse(input);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsed);
    } catch (e) {
      return input; // fallback if already formatted
    }
  }

  void addGift(String name, String url) {
    if (name.isNotEmpty && url.isNotEmpty) {
      gifts.add({'title': name, 'url': url});
    }
  }



  void removeGift(Map<String, String> gift) {
    gifts.remove(gift);
  }

  void nextStep() {
    Get.snackbar('Next', 'Proceeding to RSVP Settings...');
  }


  // Pick Date (dd-mm-yyyy)
  Future<void> pickDate(RxString target) async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      target.value = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  // Pick Date & Time
  Future<void> pickDateTime(RxString target) async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        final dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        target.value = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
      }
    }
  }

  void nextsStep() {
    Get.snackbar('Next', 'Moving to Add Guests...');
  }

  void backStep() {
    Get.back(); // or update step controller
  }
}
