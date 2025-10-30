import 'dart:developer' as dev;

import 'package:intl/intl.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/export.dart';

class ShareWithRsvpController extends GetxController {
  var isVirtual = false.obs;
  var isConfetti = false.obs;
  // var gifts = <String>[].obs;
  // RxInt selectIndex = 1.obs;
  // final isLoading = false.obs;
  //
  //
  //
  //  var cId='';
  // final eventTitle = TextEditingController();
  // final hostedBy = TextEditingController();
  // final eventDateTime = TextEditingController();
  // final address = TextEditingController();
  // final location = TextEditingController();
  // final customINvitation = TextEditingController();
  // final description = TextEditingController();


  var gifts = <Map<String, String>>[].obs; // Store title + URL
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






  @override
  void onInit() {

    super.onInit();
    print("CID!!! in arguments = ${Get.arguments} ");
    if (Get.arguments != null && Get.arguments['cId'] != null) {

      cId = Get.arguments['cId'];
      print("CID in arguments = $cId ");
    }
  }



  Future<void> hitAddEventInfoApi() async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "cId": cId,
        "event_title": eventTitle.text.trim(),
        "event_datetime": _formatDate(eventDateTime.text),
        "event_hosted_by": hostedBy.text.trim(),
        "is_virtual": isVirtual.value ? 1 : 0,
        "event_address": isVirtual.value ? null : address.text.trim(),
        "location_name": isVirtual.value ? null : location.text.trim(),
        "virtual_event_link": isVirtual.value ? virtualLink.text.trim() : null,
        "description": description.text.trim(),
        "collect_rsvp": isRsvpEnabled.value ? 1 : 0,
        "confetti": isConfetti.value ? 1 : 0,
        "rsvp_deadline": rsvpDeadline.value.isNotEmpty
            ? _formatDate(rsvpDeadline.value)
            : null,
        "allow_additional_guest": allowGuests.value == 'Yes' ? 1 : 0,
        "guest_limit": allowGuests.value == 'Yes' ? 2 : 1,
        "gift_registry": gifts,
        "custom_invitation_message": customINvitation.text.trim(),
        "send_reminders": isSendReminder.value ? 1 : 0,
        "reminder_schedule": reminderType.value,
        "custom_reminder_date": reminderType.value == "Custom"
            ? _formatDate(customReminderDate.value)
            : null,
        "schedule_at": scheduleDate.value.isNotEmpty
            ? _formatDate(scheduleDate.value)
            : null,
      };

      dev.log("📤 Request Body: $body");

      final response = await DioClient(Dio()).post(
        'v1/invitations/user/eventinfo',
        data: body,
        skipAuth: false,
      );

      dev.log("✅ API Response: ${response.toString()}");
      Get.snackbar("Success", "Event Info submitted successfully!");
    } catch (e, st) {
      dev.log('❌ hitAddEventInfoApi error: $e\n$st');
      Get.snackbar("Error", "Failed to submit event info");
    } finally {
      isLoading.value = false;
    }
  }

  String? _formatDate(String? input) {
    if (input == null || input.isEmpty) return null;
    try {
      final parsed = DateFormat('dd-MM-yyyy HH:mm').parse(input);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsed);
    } catch (e) {
      return input; // fallback if already formatted
    }
  }








  // Future<void> hitAddEventInfoApi() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final response = await DioClient(Dio())
  //         .post('v1/invitations/user/eventinfo/$cId', skipAuth: false);
  //
  //     if (response != null) {
  //       print("hitAddEventInfoApi api response  = ${response}");
  //
  //     }
  //   } catch (e, st) {
  //     dev.log('❌hitAddEventInfoApi API error: $e\n$st');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }








  void addGift(String name, String url) {
    if (name.isNotEmpty && url.isNotEmpty) {
      gifts.add({"title": name, "url": url});
    }
  }


  // void addGift(String gift) {
  //   if (gift.isNotEmpty) gifts.add(gift);
  // }

  // void removeGift(String gift) {
  //   gifts.remove(gift);
  // }

  void removeGift(Map<String, String> gift) {
    gifts.remove(gift);
  }


  void nextStep() {
    Get.snackbar("Next", "Proceeding to RSVP Settings...");
  }

  /// Second Widget
  // var isRsvpEnabled = false.obs;
  // var isSendReminder = false.obs;
  //
  // var rsvpDeadline = ''.obs;
  // var allowGuests = 'No'.obs;
  // var customInvitation = ''.obs;
  // var scheduleDate = ''.obs;
  //
  // var reminderType = '1 day before'.obs;
  // var customReminderDate = ''.obs;

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
    Get.snackbar("Next", "Moving to Add Guests...");
  }

  void backStep() {
    Get.back(); // or update step controller
  }
}
