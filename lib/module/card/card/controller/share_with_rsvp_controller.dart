import 'dart:developer' as dev;

import 'package:intl/intl.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/export.dart';

class ShareWithRsvpController extends GetxController {
  var isVirtual = false.obs;
  var isConfetti = false.obs;
  var gifts = <String>[].obs;
  RxInt selectIndex = 1.obs;
  final isLoading = false.obs;



   var cId='';
  final eventTitle = TextEditingController();
  final hostedBy = TextEditingController();
  final eventDateTime = TextEditingController();
  final address = TextEditingController();
  final location = TextEditingController();
  final customINvitation = TextEditingController();
  final description = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['cId'] != null) {
      print("CID in arguments = $cId ");
      cId = Get.arguments['cId'];
    }
  }




  Future<void> hitAddEventInfoApi() async {
    try {
      isLoading.value = true;

      final response = await DioClient(Dio())
          .post('v1/invitations/user/eventinfo/$cId', skipAuth: false);

      if (response != null) {
        print("hitAddEventInfoApi api response  = ${response}");

      }
    } catch (e, st) {
      dev.log('❌hitAddEventInfoApi API error: $e\n$st');
    } finally {
      isLoading.value = false;
    }
  }








  void addGift(String gift) {
    if (gift.isNotEmpty) gifts.add(gift);
  }

  void removeGift(String gift) {
    gifts.remove(gift);
  }

  void nextStep() {
    Get.snackbar("Next", "Proceeding to RSVP Settings...");
  }

  /// Second Widget
  var isRsvpEnabled = false.obs;
  var isSendReminder = false.obs;

  var rsvpDeadline = ''.obs;
  var allowGuests = 'No'.obs;
  var customInvitation = ''.obs;
  var scheduleDate = ''.obs;

  var reminderType = '1 day before'.obs;
  var customReminderDate = ''.obs;

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
