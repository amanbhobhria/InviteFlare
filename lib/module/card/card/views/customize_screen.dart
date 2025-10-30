import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/core_2/core/widgets/button_widget.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/module/card/card/controller/customize_controller.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:invite_flare/module/card/card/views/share_with_rsvp_screen.dart';

class CustomizeScreen extends GetView<CustomizeController> {
  const CustomizeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text('Customize Card'),
          centerTitle: true,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.undo, color: appColor),
              onPressed: controller.undo,
            ),
            IconButton(
              icon: Icon(Icons.redo, color: appColor),
              onPressed: controller.redo,
            ),
            IconButton(
              icon: Icon(Icons.text_fields, color: appColor),
              onPressed: controller.addText,
            ),
            IconButton(
              icon: Icon(Icons.save, color: appColor),
              onPressed: controller.saveScreenshot,
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: RepaintBoundary(
              key: controller.repaintKey,
              child: Stack(
                children: [
                  if (controller.backgroundImageURL.value.isNotEmpty)
                    Positioned.fill(
                      child: Image.network(
                        controller.backgroundImageURL.value,
                        // fit: BoxFit.cover,
                        fit: BoxFit.contain,
                        // alignment: Alignment.center,
                      ),
                    ),
                  ...controller.items,
                ],
              ),
            ),
          );
        }),
        bottomSheet: MaterialButtonWidget(
          onPressed: showShareBottomSheet,
          buttonText: 'Share Invitation',
          textColor: Colors.white,
        ).marginOnly(bottom: margin_30, left: margin_16, right: margin_16),
        floatingActionButton: Obx(() {
          final item = controller.activeTextItem.value;
          if (item == null) return const SizedBox.shrink();

          return FloatingActionButton(
            backgroundColor: appColor,
            onPressed: () => _showTextEditor(context, item),
            child: const Icon(Icons.edit),
          );
        }),

        //
        //
        //
        //
        // floatingActionButton: Obx(
        //       () => controller.selectedItem.value != null
        //       ? FloatingActionButton(
        //     onPressed: () =>
        //         // _showTextEditor(context, controller.selectedItem.value!),
        //         _showTextEditor(context, item),
        //     backgroundColor: appColor,
        //     child: const Icon(Icons.edit),
        //   )
        //       : const SizedBox.shrink(),
        // ),
      );
  void showShareBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Share with RSVP"),
              onTap: () {
                Get.toNamed(AppRoutes.shareWithRsvpScreen,arguments: {'cId':controller.cardId});
                // Get.to(ShareWithRsvpScreen());
                // controller.shareWithRSVP();
                // Get.back(); // Close bottom sheet
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text("Share without RSVP"),
              onTap: () {
                controller.shareWithoutRSVP();
                Get.back(); // Close bottom sheet
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTextEditor(BuildContext context, EditableTextItem item) {
    final controller = Get.find<CustomizeController>();
    // final item = controller.items
    //     .firstWhere((w) => w.key == selected.key, orElse: () => controller.items.first);

    final textCtrl = TextEditingController(text: item.text);
    double fontSize = item.fontSize;
    bool isBold = item.isBold;
    bool isItalic = item.isItalic;
    Color color = item.color;
    String fontFamily = item.fontFamily;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                autofocus: true,
                controller: textCtrl,
                decoration: const InputDecoration(labelText: 'Edit Text'),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.format_bold,
                      color: isBold ? appColor : Colors.grey,
                    ),
                    onPressed: () => setState(() => isBold = !isBold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_italic,
                      color: isItalic ? appColor : Colors.grey,
                    ),
                    onPressed: () => setState(() => isItalic = !isItalic),
                  ),
                  IconButton(
                    icon: Icon(Icons.color_lens, color: color),
                    onPressed: () => showDialog(
                      context: ctx,
                      builder: (ctx2) => AlertDialog(
                        title: const Text('Pick color'),
                        content: ColorPicker(
                          pickerColor: color,
                          onColorChanged: (c) => setState(() => color = c),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx2),
                            child: const Text('Done'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Font Size:'),
                  Expanded(
                    child: Slider(
                      min: 10,
                      max: 100,
                      value: fontSize,
                      activeColor: appColor,
                      onChanged: (v) => setState(() => fontSize = v),
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                value: fontFamily,
                items: <String>{
                  'Poppins',
                  'Roboto',
                  'DancingScript',
                  'Pacifico',
                  'Arial',
                  fontFamily
                } // ✅ Add the current fontFamily from API
                    .map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f),
                        ))
                    .toList(),
                onChanged: (f) => setState(() => fontFamily = f!),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: appColor),
                onPressed: () {
                  controller.updateTextProperty(
                    item,
                    text: textCtrl.text,
                    fontSize: fontSize,
                    isBold: isBold,
                    isItalic: isItalic,
                    color: color,
                    fontFamily: fontFamily,
                  );
                  Navigator.pop(ctx);
                },
                child: const Text('Apply'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
//
//
//
//
//
// class CustomizeScreen extends GetView<CustomizeController> {
//   const CustomizeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       elevation: 1,
//       title: const Text('Customize Card'),
//       centerTitle: true,
//       leading: IconButton(
//         onPressed: Get.back,
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.text_fields,color: appColor,),
//           onPressed: controller.addText,
//         ),
//         IconButton(
//           icon: const Icon(Icons.save,color: appColor,),
//           onPressed: controller.saveScreenshot,
//         ),
//       ],
//     ),
//     body: Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//       return Center(
//         child: RepaintBoundary(
//           key: controller.repaintKey,
//           child: Stack(
//             children: [
//               if (controller.backgroundImageURL.value.isNotEmpty)
//                 Positioned.fill(
//                   child: Image.network(
//                     controller.backgroundImageURL.value,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ...controller.items,
//             ],
//           ),
//         ),
//       );
//     }),
//     floatingActionButton: Obx(() => controller.selectedItem.value != null
//         ? FloatingActionButton(
//       onPressed: controller.deleteSelectedItem,
//       backgroundColor: appColor,
//       child: const Icon(Icons.delete),
//     )
//         : const SizedBox.shrink()),
//   );
// }
//
