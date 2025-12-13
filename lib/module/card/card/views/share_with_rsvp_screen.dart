import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/widgets/custom_textfield.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/share_with_rsvp_controller.dart';

class ShareWithRsvpScreen extends StatelessWidget {
  final controller = Get.put(ShareWithRsvpController());

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        appBarTitleText: "Please fill Details",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 16),
            Obx(
              () => controller.selectIndex.value == 1
                  ? firstWidget()
                  : controller.selectIndex.value == 2
                      ? secondWidget()
                      : thirdWidget(),
            ),
          ],
        ),
      ),
    );

  Column thirdWidget() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text('Guest Name (Optional)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFieldWidget(
          textController: controller.guestNameController,
          hint: 'e.g., John Smith',
        ),
        const SizedBox(height: 15),

        // --- Guest Email ---
        const Text('Guest Email',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFieldWidget(
          textController: controller.guestEmailController,
          inputType: TextInputType.emailAddress,
          hint: 'e.g., john.smith@example.com',

          validate: (value) {
            final text = value?.toString().trim() ?? "";

            if (text.isEmpty) {
              return "Email is required";
            }

            // ✅ Simple but strong email regex
            final emailPattern =
                r'^[\w\.-]+@[\w\.-]+\.\w+$';

            final isValidEmail = RegExp(emailPattern).hasMatch(text);

            if (!isValidEmail) {
              return "Enter a valid email address";
            }

            return null;
          },
        ) ,


        Obx(() => controller.isEmailRequired.value
            ? const Text('Email is required.',
                style: TextStyle(color: Colors.red))
            : Container()),
        const SizedBox(height: 15),

        // --- Bulk Upload & Add Guest Buttons ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: () => controller.bulkUploadEmails(),
              icon: const Icon(Icons.upload, size: 18),
              label: const Text('Bulk Upload'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal),
              ),
            ),
            ElevatedButton.icon(
              onPressed: controller.addSingleGuest,
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Add Guest',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Use a vibrant color like Teal
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // --- Paste Multiple Emails Area ---
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                textController: controller.bulkEmailController,
                maxline: 5,
                minLine: 4,
                hint:
                    'Paste emails separated by commas, semicolons, or line breaks',
              ),
              const SizedBox(height: 5),
              const Text(
                'Example: alice@mail.com, bob@mail.com, charlie@mail.com',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // --- Upgrade Link ---
        Obx(
          () => Text.rich(
            TextSpan(
              text: 'Free users can add up to ',
              style: TextStyle(color: Colors.teal.shade700, fontSize: 13),
              children: [
                TextSpan(
                  text: '${30 - controller.addedGuests.length} guests',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '. Need to invite 50+? '),
                const TextSpan(
                  text: 'Upgrade to Premium',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  // Add onTap functionality here
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),

        // --- Added Guests List ---
        Text('Added Guests (${controller.addedGuests.length})',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        // The list of added guests using Obx for reactive updates
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: controller.addedGuests
              .map((email) => _buildGuestChip(email))
              .toList(),
        ),

        const SizedBox(height: 30), // Extra space before the final buttons
        _buildBottomNavigation(),
        const SizedBox(height: 50), // Extra space before the final buttons
      ],
    );

// Helper function to build the guest 'chip'
  Widget _buildGuestChip(String email) => Chip(
      label: Text(email, style: TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: Colors.grey.shade800,
      deleteIcon: Icon(Icons.close, color: Colors.white, size: 16),
      onDeleted: () => controller.removeGuest(email),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );

  // Helper function for the fixed bottom navigation bar
  Widget _buildBottomNavigation() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                controller.selectIndex.value = 2;
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.teal),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Back', style: TextStyle(color: Colors.teal)),
            ),
          ),
          SizedBox(width: 15),
          Expanded(

            child:
  MaterialButtonWidget(
    onPressed: () {
      if(controller.addedGuests.length==0){
        Get.snackbar('', 'Add atleast one guest',colorText: appColor);

      }
      else
        {
          controller.hitAddEventInfoApi();
        }

    },
  buttonText: "Next",
  ),



          ),
        ],
      ),
    );

  Widget _buildGiftSection() {
    final giftNameController = TextEditingController();
    final giftUrlController = TextEditingController();

    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: controller.gifts
                .map((gift) => Chip(
                      label: Text("${gift['title']}"),
                      onDeleted: () => controller.removeGift(gift),
                      deleteIcon: const Icon(Icons.close, size: 18),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
      OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: appColor, width: 1),
        ),

        onPressed: () {
          Get.defaultDialog(
            title: "Add Registry",
            content: Form(
              key: controller.giftFormKey,
              child: Column(
                children: [
                  // ✅ Gift Name (Required)
                  TextFieldWidget(
                    labelText: 'Registry Name',
                    maxline: 2,
                    textController: giftNameController,
                    validate: (value) {
                      final text = value?.toString().trim() ?? "";
                      if (text.isEmpty) return 'Registry name is required';
                      return null;
                    },
                  ),

                  // ✅ Gift URL (Required + Valid)
                  TextFieldWidget(
                    labelText: 'Registry URL',
                    maxline: 1,
                    textController: giftUrlController,
                    validate: (value) {
                      final text = value?.toString().trim() ?? "";

                      if (text.isEmpty) return 'Registry URL is required';

                      const urlPattern =
                          r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}(?:\/\S*)?$';
                      final isValidUrl = RegExp(urlPattern).hasMatch(text);

                      if (!isValidUrl) return 'Please enter a valid URL';

                      return null;
                    },
                  ),
                ],
              ),
            ),

            textConfirm: "Add",
            textCancel: "Cancel",

            // ✅ Validate before adding gift
            onConfirm: () {
              final isValid = controller.giftFormKey.currentState!.validate();
              if (!isValid) return;

              controller.addGift(
                giftNameController.text,
                giftUrlController.text,
              );

              giftNameController.clear();
              giftUrlController.clear();

              Get.back();
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Gift"),
      )


        ],
      ));
  }


  Widget _buildStepIndicator() {
    Widget circle(int step, bool filled) => CircleAvatar(
          radius: 14,
          backgroundColor: filled ? Colors.green : Colors.grey.shade300,
          child: Text(
            "$step",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        );

    Widget stepText(String text) => Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
        );

    return Obx(
      () {
        final step = controller.selectIndex.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [
              circle(1, step >= 1),
              const SizedBox(width: 8),
              stepText("Event Details")
            ]),
            Container(width: 30, height: 2, color: Colors.grey),
            Row(children: [
              circle(2, step >= 2),
              const SizedBox(width: 8),
              stepText("RSVP Settings")
            ]),
            Container(width: 30, height: 2, color: Colors.grey),
            Row(children: [
              circle(3, step >= 3),
              const SizedBox(width: 8),
              stepText("Add Guests")
            ]),
          ],
        );
      },
    );
  }

  firstWidget() => Padding(
    padding: const EdgeInsets.all(16.0),

    // ✅ FORM WRAPS THE ENTIRE COLUMN
    child: Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Event Title + Hosted By
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  "Event Title",
                  "e.g., Birthday Celebration or Product Launch",
                  controller.eventTitle,
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField(
                  "Hosted By",
                  "e.g., John Smith or Acme Corporation",
                  controller.hostedBy,
                  isRequired: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Event Date & Time
          _buildTextField(
            "Event Date & Time",
            "dd-mm-yyyy --:--",
            controller.eventDateTime,
            suffixIcon: const Icon(Icons.calendar_today),
            isCalendar: true,
            isRequired: true,
          ),

          const SizedBox(height: 16),

          // Virtual Location Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Virtual Location",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Obx(() => Switch(
                inactiveThumbColor: Colors.grey.shade100,
                inactiveTrackColor: Colors.grey,
                value: controller.isVirtual.value,
                onChanged: (val) => controller.isVirtual.value = val,
              )),
            ],
          ),

          const SizedBox(height: 8),

          // Address + Location
          Obx(
                () => controller.isVirtual.value
                ? _buildTextField(
                  requiredType: 'virtual',
                  isRequired: true,
              "Virtual link",
              "https://www.google.com",
              controller.address,
            )
                : Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    isRequired: true,
                    "Address",
                    "e.g., 123 Main Street or Online Event",
                    controller.address,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    "Location (Optional)",
                    "e.g., The Grand Ballroom or Zoom Meeting",
                    controller.location,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Description
          _buildTextField(
            "Description (Optional)",
            "e.g., Join us for a fun-filled evening of music, dancing...",
            controller.description,
            maxLines: 4,
          ),

          const SizedBox(height: 16),

          // Add Confetti
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text("Add Confetti",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 5),
                  Icon(Icons.info_outline, size: 18),
                ],
              ),
              Obx(() => Switch(
                inactiveThumbColor: Colors.grey.shade100,
                inactiveTrackColor: Colors.grey,
                value: controller.isConfetti.value,
                onChanged: (val) => controller.isConfetti.value = val,
              )),
            ],
          ),

          const SizedBox(height: 16),

          // Gift Registry
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gift Registry (Optional)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 8),
          _buildGiftSection(),

          const SizedBox(height: 20),

          // ✅ Next Button Validation
          SizedBox(

            width: double.infinity,
            height: 48,
            child: MaterialButtonWidget(
              buttonText: "Next",
              onPressed: () {
                final isValid =
                controller.formKey.currentState!.validate();

                if (!isValid) {
                  print("Validation failed — some fields are empty.");
                  return;
                }

                controller.selectIndex.value = 2;
                print("index2");
              },



            ),
          ),
        ],
      ),
    ),
  );


  secondWidget() => Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "RSVP Collection",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),

        // RSVP Switch
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Enable RSVP"),
            Obx(() => Switch(
                  inactiveThumbColor: Colors.grey.shade100,
                  inactiveTrackColor: Colors.grey,
                  value: controller.isRsvpEnabled.value,
                  onChanged: (val) => controller.isRsvpEnabled.value = val,
                )),
          ],
        ),

        const SizedBox(height: 10),

        // Show RSVP fields only if enabled

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RSVP Deadline
            Obx(
              () => controller.isRsvpEnabled.value
                  ? _buildDatePicker(
                      label: "RSVP Deadline (Optional)",
                      value: controller.rsvpDeadline,
                      onTap: () => controller.pickDate(controller.rsvpDeadline),
                    )
                  : const SizedBox(),
            ),

            const SizedBox(height: 16),

            // Allow to bring additional guests
            Obx(() => controller.isRsvpEnabled.value
                ? _buildDropdown(
                    label: "Allow To Bring Additional Guests",
                    value: controller.allowGuests,
                    items: const ["Yes", "No"],
                  )
                : const SizedBox()),

            const SizedBox(height: 16),

            // Custom Invitation Message
            TextFieldWidget(
              hint: "Custom Invitation Message (Optional)",
              textController: controller.customINvitation,
              onChange: (val) => controller.customInvitation.value = val,
            ),

            const SizedBox(height: 16),

            // Schedule
            const Row(
              children: [
                Text("Schedule (Optional)",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 5),
                Icon(Icons.info_outline, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            _buildDatePicker(
              label: "Schedule Date & Time",
              value: controller.scheduleDate,
              onTap: () => controller.pickDateTime(controller.scheduleDate),
            ),

            const SizedBox(height: 16),

            // Send Reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Send Reminder",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 5),
                    InkWell(child: const Icon(Icons.info_outline, size: 18,color: appColor,),
                      onTap:() {
                        Get.defaultDialog(
                          middleText: "Remind guests about the event closer to the date.",
                          textConfirm: 'OK',
                            onConfirm:() {Get.back();},
                        );

                      },
                    ),
                  ],
                ),
                Obx(() => Switch(
                      inactiveThumbColor: Colors.grey.shade100,
                      inactiveTrackColor: Colors.grey,
                      value: controller.isSendReminder.value,
                      onChanged: (val) => controller.isSendReminder.value = val,
                    )),
              ],
            ),

            const SizedBox(height: 10),

            // Reminder Section
            Obx(() {
              if (!controller.isSendReminder.value) return const SizedBox();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reminder Schedule",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    label: "Reminder Type",
                    value: controller.reminderType,
                    items: const ["1 day before", "2 days before", "Custom"],
                  ),
                  const SizedBox(height: 16),

                  // Custom Date if selected
                  if (controller.reminderType.value == "Custom")
                    _buildDatePicker(
                      label: "Custom Date",
                      value: controller.customReminderDate,
                      onTap: () => controller
                          .pickDateTime(controller.customReminderDate),
                    ),
                ],
              );
            }),
          ],
        ),

        const SizedBox(height: 24),

        // Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  controller.selectIndex.value = 1;
                },
                child: const Text("Back"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: MaterialButtonWidget(
              onPressed: () {
                print("index3");

                print("index4");

                controller.selectIndex.value = 3;
              },
              buttonText: "Next",
            )),
          ],
        ),
      ],
    );








  Future<void> pickEventDateTime() async {
    // Pick Date
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // Pick Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    // Combine date + time
    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Format to API required: YYYY-MM-DD HH:MM:SS
    final formatted =
        "${finalDateTime.year.toString().padLeft(4, '0')}-"
        "${finalDateTime.month.toString().padLeft(2, '0')}-"
        "${finalDateTime.day.toString().padLeft(2, '0')} "
        "${finalDateTime.hour.toString().padLeft(2, '0')}:"
        "${finalDateTime.minute.toString().padLeft(2, '0')}:00";

    controller.eventDateTime.text = formatted;
  }




  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller, {
        Widget? suffixIcon,
        int maxLines = 1,
        bool isRequired = false,
        String? requiredType,
        bool isCalendar = false,
        Function(String)? onChanged,
      }) => TextFieldWidget(
      textController: controller,
      readOnly: isCalendar,
      maxline: maxLines,
      labelText: label,
      hint: hint,
      suffixIcon: suffixIcon,

      onTap: () {
        if (isCalendar) {
          pickEventDateTime();
        }
      },

      validate: isRequired
          ? (value) {
        final text = value?.toString().trim() ?? "";

        // ✅ Required validation
        if (text.isEmpty) {
          if (requiredType == 'virtual') {
            return 'Virtual link is required';
          }
          return '$label is required';
        }

        // ✅ URL validation for virtual links
        if (requiredType == 'virtual') {
          final urlPattern =
              r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}(?:\/\S*)?$';
          final isValidUrl = RegExp(urlPattern).hasMatch(text);

          if (!isValidUrl) {
            return 'Please enter a valid link';
          }
        }

        return null;
      }
          : null,
    );









  // ---------------- Widgets ----------------
  // Widget _buildTextField(
  //     String label, String hint, TextEditingController controller,
  //     {Widget? suffixIcon, int maxLines = 1,
  //       bool isRequired = false,
  //       var requiredType,
  //       bool isCalendar=false, Function(String)? onChanged}) => TextFieldWidget(
  //     textController: controller,
  //     readOnly: isCalendar,
  //
  //     maxline: maxLines,
  //     labelText: label,
  //     hint: hint,
  //     suffixIcon: suffixIcon,
  //    onTap: () => {
  //       if(isCalendar==true){
  //         pickEventDateTime(),
  //       }
  //
  //
  //    },
  //   validate: isRequired
  //       ? (value) {
  //     if (value == null || value.toString().trim().isEmpty) {
  //       if (requiredType == 'virtual') {
  //         if (value.isEmpty) {
  //           return 'Virtual link is required';
  //         }
  //
  //         final urlPattern =
  //             r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}(?:\/\S*)?$';  // ✅ Simple URL regex
  //         final isValidUrl = RegExp(urlPattern).hasMatch(value);
  //
  //         if (!isValidUrl) {
  //           return 'Please enter a valid link';
  //         }
  //       }
  //
  //       return '$label is required';
  //     }
  //     return null;
  //   }
  //       : null,
  // );





  Widget _buildDropdown(
      {required String label,
      required RxString value,
      required List<String> items}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Obx(() => DropdownButtonFormField<String>(
              value: value.value,
              onChanged: (val) => value.value = val!,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              ),
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
            )),
      ],
    );

  Widget _buildDatePicker(
      {required String label,
      required RxString value,
      required VoidCallback onTap}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Obx(() => TextFieldWidget(
              readOnly: true,
              textController: TextEditingController(text: value.value),
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: onTap,
            )),
      ],
    );
}
