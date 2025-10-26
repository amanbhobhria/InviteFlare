import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';


import 'dart:async';



enum ItemType { text }

class SelectedItem {
  final Key key;
  final ItemType type;
  SelectedItem(this.key, this.type);
}

class CustomizeController extends GetxController {
  var cardId;
  final repaintKey = GlobalKey();
  final isLoading = false.obs;

  Rx<EditableTextItem?> activeTextItem = Rx<EditableTextItem?>(null);



  final backgroundImageURL = ''.obs;
  final items = <EditableTextItem>[].obs;
  final selectedItem = Rxn<SelectedItem>();

  // Undo / Redo stacks
  final _undoStack = <List<EditableTextItem>>[];
  final _redoStack = <List<EditableTextItem>>[];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['cardId'] != null) {
      cardId = Get.arguments['cardId'];
      callCustomizeCardApi(cardId);
    }
  }

  void _saveStateForUndo() {
    _undoStack.add(List.from(items.map((e) => e.copy())));
    _redoStack.clear();
  }

  void undo() {
    if (_undoStack.isEmpty) return;
    _redoStack.add(List.from(items.map((e) => e.copy())));
    final prev = _undoStack.removeLast();
    items.assignAll(prev);
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    _undoStack.add(List.from(items.map((e) => e.copy())));
    final next = _redoStack.removeLast();
    items.assignAll(next);
  }


  Future<void> callCustomizeCardApi(cardId) async {
    try {
      isLoading.value = true;

      final response = await DioClient(Dio())
          .get('v1/invitations/cards/customize/$cardId', skipAuth: false);

      if (response != null) {
        final dynamic cardData = response['card'];
        Map<String, dynamic> data =
        cardData is String ? jsonDecode(cardData) : cardData;

        // background
        backgroundImageURL.value = data['settings']?['background_image'] ?? '';

        final texts = data['texts'] ?? [];
        items.clear();

        // Wait for layout to build before positioning
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final context = Get.context;
          if (context == null) return;

          final renderBox =
          repaintKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox == null) return;

          final containerWidth = renderBox.size.width;
          final containerHeight = renderBox.size.height;

          // Get image actual size
          final imageProvider = NetworkImage(backgroundImageURL.value);
          final completer = Completer<ImageInfo>();
          imageProvider.resolve(const ImageConfiguration()).addListener(
            ImageStreamListener((info, _) {
              completer.complete(info);
            }),
          );
          final imageInfo = await completer.future;
          final originalImageWidth = imageInfo.image.width.toDouble();
          final originalImageHeight = imageInfo.image.height.toDouble();

          // Compute scale for BoxFit.contain
          final scale = [
            containerWidth / originalImageWidth,
            containerHeight / originalImageHeight
          ].reduce((a, b) => a < b ? a : b); // min scale
          final renderedWidth = originalImageWidth * scale;
          final renderedHeight = originalImageHeight * scale;

          // Offsets to center image in container
          final offsetX = (containerWidth - renderedWidth) / 2;
          final offsetY = (containerHeight - renderedHeight) / 2;

          for (final t in texts) {
            final settings = t['settings'] ?? {};
            final fontSize = double.tryParse(settings['font_size']?.toString() ?? '') ?? 28;
            final fontWeight = settings['font_weight']?.toString().toLowerCase() == 'bold';
            final fontStyle = settings['font_style']?.toString().toLowerCase() == 'italic';
            final colorHex = (settings['font_color'] as String?)?.replaceFirst('#', '') ?? '000000';
            final color = Color(int.parse('0xFF$colorHex'));
            final fontFamily = (settings['font_family'] ?? 'Poppins').toString();

            // Parse positions
            final leftPercent = double.tryParse(settings['left'].toString()) ?? 0.0;
            final topPercent = double.tryParse(settings['top'].toString()) ?? 0.0;

            // Scale positions to rendered image
            final left = offsetX + (leftPercent / 100) * renderedWidth;
            final top = offsetY + (topPercent / 100) * renderedHeight;

            final id = t['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();

            late EditableTextItem textItem;
            textItem = EditableTextItem(
              key: ValueKey(id),
              text: t['text'] ?? '',
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
              isBold: fontWeight,
              isItalic: fontStyle,
              left: left,
              top: top,
              onSelect: () {
                selectedItem.value = SelectedItem(ValueKey(id), ItemType.text);
                activeTextItem.value = textItem; // proper reference
              },
            );

            items.add(textItem);
          }

          dev.log('✅ Texts positioned precisely on image: ${items.length}');
        });
      }
    } catch (e, st) {
      dev.log('❌ API error: $e\n$st');
    } finally {
      isLoading.value = false;
    }
  }







  // Future<void> callCustomizeCardApi(cardId) async {
  //   try {
  //     isLoading.value = true;
  //
  //     final response = await DioClient(Dio())
  //         .get('v1/invitations/cards/customize/$cardId', skipAuth: false);
  //
  //     if (response != null) {
  //       final dynamic cardData = response['card'];
  //       Map<String, dynamic> data =
  //       cardData is String ? jsonDecode(cardData) : cardData;
  //
  //       // background
  //       backgroundImageURL.value = data['settings']?['background_image'] ?? '';
  //
  //       final texts = data['texts'] ?? [];
  //       items.clear();
  //
  //       // Wait for layout to build before positioning
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         final context = Get.context;
  //         if (context == null) return;
  //
  //         final renderBox =
  //         repaintKey.currentContext?.findRenderObject() as RenderBox?;
  //         if (renderBox == null) return;
  //
  //         final imageWidth = renderBox.size.width;
  //         final imageHeight = renderBox.size.height;
  //
  //         for (final t in texts) {
  //           final settings = t['settings'] ?? {};
  //           final fontSize = double.tryParse(settings['font_size']?.toString() ?? '') ?? 28;
  //           final fontWeight =
  //               settings['font_weight']?.toString().toLowerCase() == 'bold';
  //           final fontStyle =
  //               settings['font_style']?.toString().toLowerCase() == 'italic';
  //           final colorHex =
  //               (settings['font_color'] as String?)?.replaceFirst('#', '') ?? '000000';
  //           final color = Color(int.parse('0xFF$colorHex'));
  //           final fontFamily = (settings['font_family'] ?? 'Poppins').toString();
  //
  //           // Parse percentages directly (not from "%")
  //           final leftPercent =
  //               double.tryParse(settings['left'].toString()) ?? 0.0;
  //           final topPercent =
  //               double.tryParse(settings['top'].toString()) ?? 0.0;
  //
  //           // Scale to actual image size
  //           final left = (leftPercent / 100) * imageWidth;
  //           final top = (topPercent / 100) * imageHeight;
  //
  //           final id = t['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
  //
  //           // items.add(
  //           //   EditableTextItem(
  //           //     key: ValueKey(id),
  //           //     text: t['text'] ?? '',
  //           //     color: color,
  //           //     fontFamily: fontFamily,
  //           //     fontSize: fontSize,
  //           //     isBold: fontWeight,
  //           //     isItalic: fontStyle,
  //           //     left: left,
  //           //     top: top,
  //           //        onSelect: () => selectedItem.value =
  //           //         SelectedItem(ValueKey(id), ItemType.text),
  //           //   ),
  //           // );
  //
  //           late EditableTextItem textItem;
  //
  //           textItem = EditableTextItem(
  //             key: ValueKey(id),
  //             text: t['text'] ?? '',
  //             color: color,
  //             fontFamily: fontFamily,
  //             fontSize: fontSize,
  //             isBold: fontWeight,
  //             isItalic: fontStyle,
  //             left: left,
  //             top: top,
  //             onSelect: () {
  //               selectedItem.value = SelectedItem(ValueKey(id), ItemType.text);
  //               activeTextItem.value = textItem; // ✅ proper reference
  //             },
  //           );
  //
  //           items.add(textItem);
  //
  //
  //
  //
  //
  //         }
  //
  //
  //
  //
  //
  //         dev.log('✅ Texts positioned precisely on image: ${items.length}');
  //       });
  //     }
  //   } catch (e, st) {
  //     dev.log('❌ API error: $e\n$st');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void addText() {
    _saveStateForUndo();
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    // Create text item instance first
    late EditableTextItem textItem;

    textItem = EditableTextItem(
      key: ValueKey(id),
      text: 'New Text',
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 24,
      isBold: false,
      isItalic: true,
      left: 50,
      top: 50,
      onSelect: () {
        selectedItem.value = SelectedItem(ValueKey(id), ItemType.text);
        activeTextItem.value = textItem; // ✅ correct reference
      },
    );

    // Then add to items
    items.add(textItem);
  }






  void deleteSelectedItem() {
    if (selectedItem.value == null) return;
    _saveStateForUndo();
    items.removeWhere((w) => w.key == selectedItem.value!.key);
    selectedItem.value = null;
  }

  void updateTextProperty(EditableTextItem item, {
    String? text,
    double? fontSize,
    bool? isBold,
    bool? isItalic,
    Color? color,
    String? fontFamily,
  }) {
    _saveStateForUndo();
    final updated = item.copy(
      text: text ?? item.text,
      fontSize: fontSize ?? item.fontSize,
      isBold: isBold ?? item.isBold,
      isItalic: isItalic ?? item.isItalic,
      color: color ?? item.color,
      fontFamily: fontFamily ?? item.fontFamily,
    );
    final idx = items.indexWhere((w) => w.key == item.key);
    if (idx != -1) items[idx] = updated;
  }

  Future<void> saveScreenshot() async {
    try {
      RenderRepaintBoundary boundary =
      repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final base64Image = base64Encode(pngBytes);
      await uploadScreenshot(base64Image);
    } catch (e) {
      dev.log('Screenshot error: $e');
    }
  }

  Future<void> uploadScreenshot(String base64Image) async {
    try {
      isLoading.value = true;
      final payload = {
        'cId': cardId,
        'files': 'data:image/jpeg;base64,$base64Image',
      };
      await DioClient(Dio())
          .patch('v1/invitations/cards/customize/image/upload',
          data: payload, skipAuth: false)
          .then((value) {
        if (value != null) {
          Get.snackbar('Success', 'Image uploaded successfully',
              snackPosition: SnackPosition.BOTTOM);
        }
      }).onError((error, stackTrace) {
        NetworkExceptions.getDioException(error);
      });
    } finally {
      isLoading.value = false;
    }
  }
}

/// Editable text item model + widget
class EditableTextItem extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final bool isItalic;
  final Color color;
  final String fontFamily;
  final double left;
  final double top;
  final VoidCallback onSelect;

  const EditableTextItem({
    super.key,
    required this.text,
    required this.fontSize,
    required this.isBold,
    required this.isItalic,
    required this.color,
    required this.fontFamily,
    required this.left,
    required this.top,
    required this.onSelect,
  });

  EditableTextItem copy({
    String? text,
    double? fontSize,
    bool? isBold,
    bool? isItalic,
    Color? color,
    String? fontFamily,
    double? left,
    double? top,
  }) =>
      EditableTextItem(
        key: key,
        text: text ?? this.text,
        fontSize: fontSize ?? this.fontSize,
        isBold: isBold ?? this.isBold,
        isItalic: isItalic ?? this.isItalic,
        color: color ?? this.color,
        fontFamily: fontFamily ?? this.fontFamily,
        left: left ?? this.left,
        top: top ?? this.top,
        onSelect: onSelect,
      );

  @override
  Widget build(BuildContext context) => Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onSelect,
        onPanUpdate: (details) {
          final controller = Get.find<CustomizeController>();
          controller._saveStateForUndo();
          final idx = controller.items.indexWhere((i) => i.key == key);
          if (idx != -1) {
            controller.items[idx] = copy(
              left: left + details.delta.dx,
              top: top + details.delta.dy,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          padding: const EdgeInsets.all(4),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ),
    );
}



//
//
//
//
// double parseDimension(String? raw, double total) {
//   if (raw == null) return 0;
//   final str = raw.trim();
//   final numberStr = str.endsWith('%') ? str.substring(0, str.length - 1) : str;
//   final percent = double.tryParse(numberStr) ?? 0.0;
//   return total * percent / 100.0;
// }

// String mapWebFontToFlutter(String font) {
//   switch (font) {
//     case 'poppins-regular':
//       return 'Poppins';
//     case 'dancing-script-normal':
//       return 'DancingScript';
//     default:
//       return font;
//   }
// }
//
// enum ItemType { text, image }
//
// class SelectedItem {
//   final Key key;
//   final ItemType type;
//   SelectedItem(this.key, this.type);
// }
//
// class CustomizeController extends GetxController {
//   var cardId;
//   final repaintKey = GlobalKey();
//   final isLoading = false.obs;
//
//   final backgroundImageURL = ''.obs;
//   final backgroundColor = Rxn<Color>();
//   final items = <Widget>[].obs;
//   final selectedItem = Rxn<SelectedItem>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (Get.arguments != null && Get.arguments['cardId'] != null) {
//       cardId = Get.arguments['cardId'];
//       callCustomizeCardApi(cardId);
//     }
//   }
//
//   Future<void> callCustomizeCardApi(cardId) async {
//     try {
//       isLoading.value = true;
//       final response = await DioClient(Dio())
//           .get('v1/invitations/cards/customize/$cardId', skipAuth: false);
//       if (response != null) {
//         final dynamic cardData = response['card'];
//         Map<String, dynamic> data =
//         cardData is String ? jsonDecode(cardData) : cardData;
//         backgroundImageURL.value = data['settings']?['background_image'] ?? '';
//         // Load text widgets
//         final texts = data['texts'] ?? [];
//         for (final textData in texts) {
//           items.add(createTextItem(
//             textData['id'],
//             textData['text'],
//             textData['settings'],
//           ));
//         }
//       }
//     } catch (e, st) {
//       dev.log('❌ API error: $e\n$st');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Widget createTextItem(String id, String text, Map<String, dynamic>? settings) {
//     return EditableTextItem(
//       key: ValueKey(id),
//       text: text,
//       textData: settings ?? {},
//       onDelete: deleteSelectedItem,
//       onSelect: () => selectedItem.value = SelectedItem(ValueKey(id), ItemType.text),
//     );
//   }
//
//   void addText() {
//     final randomId =
//     List.generate(6, (_) => Random().nextInt(36).toRadixString(36)).join();
//     items.add(
//       createTextItem(randomId, 'New Text', {
//         'left': '10%',
//         'top': '10%',
//         'font_size': '24',
//         'font_color': '#000000',
//         'font_weight': 'normal',
//         'font_style': 'normal',
//         'font_family': 'Arial',
//         'rotate': '0deg',
//       }),
//     );
//   }
//
//   void deleteSelectedItem() {
//     if (selectedItem.value == null) return;
//     items.removeWhere((w) => w.key == selectedItem.value!.key);
//     selectedItem.value = null;
//   }
//
//   Future<void> saveScreenshot() async {
//     try {
//       RenderRepaintBoundary boundary =
//       repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//       await image.toByteData(format: ui.ImageByteFormat.png);
//       if (byteData == null) return;
//       Uint8List pngBytes = byteData.buffer.asUint8List();
//       final base64Image = base64Encode(pngBytes);
//       await uploadScreenshot(base64Image);
//     } catch (e) {
//       dev.log('Screenshot error: $e');
//     }
//   }
//
//   Future<void> uploadScreenshot(String base64Image) async {
//     try {
//       isLoading.value = true;
//       final payload = {
//         'cId': cardId,
//         'files': 'data:image/jpeg;base64,$base64Image',
//       };
//       await DioClient(Dio())
//           .patch('v1/invitations/cards/customize/image/upload',
//           data: payload, skipAuth: false)
//           .then((value) {
//         if (value != null) {
//           Get.snackbar('Success', 'Image uploaded successfully',
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       }).onError((error, stackTrace) {
//         NetworkExceptions.getDioException(error);
//       });
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// /// Editable text widget
// class EditableTextItem extends StatefulWidget {
//   String text;
//   final Map<String, dynamic> textData;
//   final VoidCallback onDelete;
//   final VoidCallback onSelect;
//
//   EditableTextItem({
//     super.key,
//     required this.text,
//     required this.textData,
//     required this.onDelete,
//     required this.onSelect,
//   });
//
//   @override
//   State<EditableTextItem> createState() => _EditableTextItemState();
// }
//
// class _EditableTextItemState extends State<EditableTextItem> {
//   double _fontSize = 24.0;
//   bool _isBold = false;
//   bool _isItalic = false;
//   Color _color = Colors.black;
//   double _rotationAngle = 0.0;
//   String _fontFamily = 'Arial';
//
//   @override
//   void initState() {
//     super.initState();
//     final data = widget.textData;
//     _fontSize = double.tryParse(data['font_size']?.toString() ?? '') ?? 24.0;
//     _isBold = data['font_weight'] == 'bold';
//     _isItalic = data['font_style'] == 'italic';
//     _fontFamily = mapWebFontToFlutter(data['font_family'] ?? 'Arial');
//     final hex =
//         (data['font_color'] as String?)?.replaceFirst('#', '') ?? '000000';
//     _color = Color(int.parse('0xFF$hex'));
//     final rot = data['rotate']?.toString() ?? '0deg';
//     final deg = rot.endsWith('deg')
//         ? double.tryParse(rot.replaceAll('deg', '')) ?? 0
//         : double.tryParse(rot) ?? 0;
//     _rotationAngle = deg * pi / 180;
//   }
//
//   void editTextProperties() {
//     final ctl = TextEditingController(text: widget.text);
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) => StatefulBuilder(
//         builder: (ctx, setState) => Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             TextField(
//               controller: ctl,
//               decoration: const InputDecoration(labelText: 'Edit Text'),
//               onChanged: (v) => widget.text = v,
//             ),
//             DropdownButton<String>(
//               value: _fontFamily,
//               items: [
//                 'Arial',
//                 'Roboto',
//                 'Times New Roman',
//                 'DancingScript',
//                 'great-vibes-regular',
//                 'pacifico-regular'
//               ]
//                   .map((f) => DropdownMenuItem(value: f, child: Text(f)))
//                   .toList(),
//               onChanged: (f) => setState(() => _fontFamily = f!),
//             ),
//             Row(children: [
//               const Text('Bold'),
//               Checkbox(value: _isBold, onChanged: (v) => setState(() => _isBold = v!)),
//               const Text('Italic'),
//               Checkbox(value: _isItalic, onChanged: (v) => setState(() => _isItalic = v!)),
//             ]),
//             TextButton(
//               child: const Text('Pick Color'),
//               onPressed: () {
//                 showDialog(
//                   context: ctx,
//                   builder: (ctx2) => AlertDialog(
//                     content: ColorPicker(
//                       pickerColor: _color,
//                       onColorChanged: (c) => setState(() => _color = c),
//                     ),
//                     actions: [
//                       TextButton(
//                           child: const Text('Done'),
//                           onPressed: () => Navigator.pop(ctx2)),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             DropdownButton<double>(
//               value: _fontSize,
//               items: List.generate(80, (i) => (i + 8).toDouble())
//                   .map((s) => DropdownMenuItem(
//                 value: s,
//                 child: Text('${s.toInt()}px'),
//               ))
//                   .toList(),
//               onChanged: (s) => setState(() => _fontSize = s!),
//             ),
//             ElevatedButton(
//               child: const Text('Save'),
//               onPressed: () {
//                 widget.textData
//                   ..['font_family'] = _fontFamily
//                   ..['font_weight'] = _isBold ? 'bold' : 'normal'
//                   ..['font_style'] = _isItalic ? 'italic' : 'normal'
//                   ..['font_size'] = _fontSize.toString()
//                   ..['font_color'] =
//                       '#${_color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
//                 setState(() {});
//                 Navigator.pop(ctx);
//               },
//             )
//           ]),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final parent = MediaQuery.of(context).size;
//     final dx = parseDimension(widget.textData['left']?.toString(), parent.width);
//     final dy = parseDimension(widget.textData['top']?.toString(), parent.height);
//     final unescape = HtmlUnescape();
//     final displayText = unescape.convert(widget.text);
//
//     return Positioned(
//       left: dx,
//       top: dy,
//       child: GestureDetector(
//         onTap: widget.onSelect,
//         onLongPress: editTextProperties,
//         onScaleUpdate: (details) {
//           setState(() {
//             final newX = dx + details.focalPointDelta.dx;
//             final newY = dy + details.focalPointDelta.dy;
//             final pctX = (newX / parent.width) * 100;
//             final pctY = (newY / parent.height) * 100;
//             widget.textData['left'] = '${pctX.toStringAsFixed(2)}%';
//             widget.textData['top'] = '${pctY.toStringAsFixed(2)}%';
//             _fontSize = (_fontSize * details.scale).clamp(12.0, 72.0);
//             _rotationAngle += details.rotation;
//             widget.textData['rotate'] =
//             '${(_rotationAngle * 180 / pi).toStringAsFixed(1)}deg';
//           });
//         },
//         child: Transform.rotate(
//           angle: _rotationAngle,
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             child: Text(
//               displayText,
//               style: TextStyle(
//                 fontFamily: _fontFamily,
//                 fontSize: _fontSize,
//                 color: _color,
//                 fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
//                 fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
