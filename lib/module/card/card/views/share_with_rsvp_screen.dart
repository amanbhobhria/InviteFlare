// ignore_for_file: prefer_expression_function_bodies

import 'package:invite_flare/core_2/core/widgets/custom_textfield.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/share_with_rsvp_controller.dart';

class ShareWithRsvpScreen extends StatelessWidget {
  final controller = Get.put(ShareWithRsvpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  : secondWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftSection() {
    final giftController = TextEditingController();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: controller.gifts
                .map((gift) => Chip(
                      label: Text(gift),
                      onDeleted: () => controller.removeGift(gift),
                      deleteIcon: const Icon(Icons.close, size: 18),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              Get.defaultDialog(
                title: "Add Gift",
                content: TextField(
                  controller: giftController,
                  decoration: const InputDecoration(
                    labelText: "Gift Name",
                  ),
                ),
                textConfirm: "Add",
                textCancel: "Cancel",
                onConfirm: () {
                  controller.addGift(giftController.text);
                  giftController.clear();
                  Get.back();
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Gift"),
          ),
        ],
      );
    });
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

  firstWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField(
                  "Hosted By",
                  "e.g., John Smith or Acme Corporation",
                  controller.hostedBy,
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
                    "Virtual link",
                    "https://www.google.com",
                    controller.address,
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
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
              Row(
                children: const [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Gift Registry (Optional)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 8),
          _buildGiftSection(),

          const SizedBox(height: 20),

          // Next Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: MaterialButtonWidget(
              onPressed: () {
                controller.selectIndex.value = 2;
              },
              buttonText: "Next",
            ),
          ),
        ],
      ),
    );
  }

  secondWidget() {
    return Column(
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
                  : SizedBox(),
            ),

            const SizedBox(height: 16),

            // Allow to bring additional guests
            Obx(() => controller.isRsvpEnabled.value
                ? _buildDropdown(
                    label: "Allow To Bring Additional Guests",
                    value: controller.allowGuests,
                    items: const ["Yes", "No"],
                  )
                : SizedBox()),

            const SizedBox(height: 16),

            // Custom Invitation Message
            TextFieldWidget(
              hint: "Custom Invitation Message (Optional)",
              textController: controller.customINvitation,
              onChange: (val) => controller.customInvitation.value = val,
            ),

            const SizedBox(height: 16),

            // Schedule
            Row(
              children: const [
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
                  children: const [
                    Text("Send Reminder",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(width: 5),
                    Icon(Icons.info_outline, size: 18),
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
                controller.selectIndex.value = 3;
              },
              buttonText: "Next",
            )),
          ],
        ),
      ],
    );
  }

  // ---------------- Widgets ----------------
  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {Widget? suffixIcon, int maxLines = 1, Function(String)? onChanged}) {
    return TextFieldWidget(
      textController: controller,
      maxline: maxLines,
      labelText: label,
      hint: hint,
      suffixIcon: suffixIcon,
      // decoration: InputDecoration(
      //   labelText: label,
      //   hintText: hint,
      //   suffixIcon: suffixIcon,
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(6),
      //   ),
      // ),
    );
  }

  // Widget _buildTextField(
  //     {required String label, required Function(String) onChanged}) {
  //   return TextField(
  //     onChanged: onChanged,
  //     maxLines: 3,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
  //     ),
  //   );
  // }

  Widget _buildDropdown(
      {required String label,
      required RxString value,
      required List<String> items}) {
    return Column(
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
  }

  Widget _buildDatePicker(
      {required String label,
      required RxString value,
      required VoidCallback onTap}) {
    return Column(
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
}
