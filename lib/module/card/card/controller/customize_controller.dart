import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';

import 'dart:async';

import 'package:invite_flare/module/card/model/customize_card_model.dart';

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
  CustomizeCardModel? customizeModel;


  Rx<EditableTextItem?> activeTextItem = Rx<EditableTextItem?>(null);

  final backgroundImageURL = ''.obs;
  final items = <EditableTextItem>[].obs;
  final selectedItem = Rxn<SelectedItem>();
  var userCid = '';

  // Undo / Redo stacks
  final _undoStack = <List<EditableTextItem>>[];
  final _redoStack = <List<EditableTextItem>>[];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['cardId'] != null) {
      cardId = Get.arguments['cardId'];
      // cardId="Sudz78cYWWSk";
      // callCustomizeCardApi(cardId);
      callCustomizeCardApi2(cardId);
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

  Future<void> shareWithoutRSVP() async {
    try {
      isLoading.value = true;

      final response = await DioClient(Dio())
          .get('v1/invitations/cards/display/$cardId', skipAuth: false);

      if (response != null) {
        print('shareWithoutRSVP api response  = ${response}');
      }
    } catch (e, st) {
      dev.log('❌shareWithoutRSVP API error: $e\n$st');
    } finally {
      isLoading.value = false;
    }
  }


  final dioClient = DioClient(Dio());






  //without model
  Future<void> callCustomizeCardApi(cardId) async {
    debugPrint('callCustomizeCardApi1');
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
            final fontSize =
                double.tryParse(settings['font_size']?.toString() ?? '') ?? 28;
            final fontWeight =
                settings['font_weight']?.toString().toLowerCase() == 'bold';
            final fontStyle =
                settings['font_style']?.toString().toLowerCase() == 'italic';
            final colorHex =
                (settings['font_color'] as String?)?.replaceFirst('#', '') ??
                    '000000';
            final color = Color(int.parse('0xFF$colorHex'));
            final fontFamily =
                (settings['font_family'] ?? 'Poppins').toString();

            // Parse positions
            final leftPercent =
                double.tryParse(settings['left'].toString()) ?? 0.0;
            final topPercent =
                double.tryParse(settings['top'].toString()) ?? 0.0;

            // Scale positions to rendered image
            final left = offsetX + (leftPercent / 100) * renderedWidth;
            final top = offsetY + (topPercent / 100) * renderedHeight;

            final id =
                t['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();

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


  //with model
  Future<void> callCustomizeCardApi2(cardId) async {
    debugPrint('callCustomizeCardApi2');
    try {
      isLoading.value = true;

      final response = await DioClient(Dio())
          .get('v1/invitations/cards/customize/$cardId', skipAuth: false);

      if (response != null) {
        final dynamic cardData = response['card'];
        Map<String, dynamic> data =
        cardData is String ? jsonDecode(cardData) : cardData;

        /// ✅ Create and store model instance
        customizeModel = CustomizeCardModel.fromJson({
          'cId': cardId,
          ...data,
        });

        /// ✅ Background Image
        backgroundImageURL.value =
            customizeModel?.settings?.backgroundImage ?? '';

        final texts = customizeModel?.texts ?? [];
        items.clear();

        // Wait for layout build before positioning
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final context = Get.context;
          if (context == null) return;

          final renderBox =
          repaintKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox == null) return;

          final containerWidth = renderBox.size.width;
          final containerHeight = renderBox.size.height;

          // Get actual image size
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
            containerHeight / originalImageHeight,
          ].reduce((a, b) => a < b ? a : b);

          final renderedWidth = originalImageWidth * scale;
          final renderedHeight = originalImageHeight * scale;

          // Center image in container
          final offsetX = (containerWidth - renderedWidth) / 2;
          final offsetY = (containerHeight - renderedHeight) / 2;

          for (final textModel in texts) {
            final s = textModel.settings;
            if (s == null) continue;

            // Convert positions from % → actual pixel
            final left = offsetX + ((s.left ?? 0.0) / 100) * renderedWidth;
            final top = offsetY + ((s.top ?? 0.0) / 100) * renderedHeight;

            // Convert color from hex
            final color = Color(
              int.parse(
                (s.fontColor ?? '#000000').replaceFirst('#', '0xFF'),
              ),
            );

            final id = textModel.id ?? DateTime.now().millisecondsSinceEpoch.toString();

            late EditableTextItem item;
            item = EditableTextItem(
              key: ValueKey(id),
              text: textModel.text ?? '',
              color: color,
              fontFamily: s.fontFamily ?? 'Poppins',
              fontSize: s.fontSize ?? 28,
              isBold: (s.fontWeight ?? '').toLowerCase() == 'bold',
              isItalic: (s.fontStyle ?? '').toLowerCase() == 'italic',
              left: left,
              top: top,
              onSelect: () {
                selectedItem.value = SelectedItem(ValueKey(id), ItemType.text);
                activeTextItem.value = item;
              },
            );

            // ✅ Add UI item
            items.add(item);
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

  ///changes
  Future<void> updateCardApi() async {
    print("updates  updateCardApi");
    var token = await TokenService().getAccessToken();

    print("updates  with token = $token");


    try{
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':'Bearer ${token}'
        // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5ZDFjNGM1YS0yZDJiLTQ2OTItOGYyZi02M2VmNDcxMmJhMDYiLCJqdGkiOiIzNmYxZmJmMTJlYzJjNTc2OWY2OTk1ODhkZDhhMGZlODhkNTgxODRmYjZiYjM2YzQ2YzhiZTVhOGJjYTdkNTEyNTQ1NDE0NzJiN2Q2MGNkOSIsImlhdCI6MTc2MjA2OTU2OC4zMTMzODIsIm5iZiI6MTc2MjA2OTU2OC4zMTMzODQsImV4cCI6MTc2MjA4Mzk2OC4yOTYzMzIsInN1YiI6Ijc3Iiwic2NvcGVzIjpbIioiXX0.UfZO_-QSqU33PhGCMw-vZZmbKqvRCLl0R8F6gB2j52PNMsu5gnXHEs2h6spOsDHbS2ui8tIUGC2DnBro_XlbpwfZaocdIOZ5CrV7xY9SgVCEOmdOM_2tY4Ja-uScxQK1PB2SH6FrXuutZfzNuQD6sU3p2F79S0K_oZxjdxXyyjIY81NlnTLZKzGMUbxfoETrdTALCeW95kyP1oq_fIp4UsvS95HTkL6Hz4ncVEyEd35Wsuipzu21HstK9p0T0olI19Jr6mZuJmvMtQoW-WwSWZvdH-M_4tZMIggV9fDDlWvX2ETsJsIBH4NjgbHaYtkh6sqMj1JYp_Ga4L03Hzae1hKe1DVbWWJPMP-T0_XtUzkcG6SjJNPuI-hOVGJNfBHiknhxfkY-HxIGS3M5oe8--s5iT5zEpEmyFgiQqJKZaXqXRWs09q1H1N_rYowoyE9IJ_WFwBmXUfCfnxiytK8BokOuBy50EGyxRfVJRYeFikGGToba0A70XrjPrEiHOnFNICI0lqsEJtQh95o4tImsubzhSNepzGmeGGUo-V1WTwOYu7RaFtb9MfDxc7h-aiDrqh_kqlwb0d7_nlSwBBabgO-P3GqbfCx3omuAjYyC_3_ikXdEsqMMhou_Bb1xrlCEX1xq3JvlMbhJrXZKB0Nantc-QGVux4tovoHms68sWsU'
      };
      var data = json.encode({
        'cId': cardId,
        'type': 'invitation',
        'cData':
        '{"front":{"settings":{"background_image":"https://images.inviteflare.com/images/invitations/default/fad504b1-89de-4aad-8307-6a4dc3867556_1750949833.png"},"texts":[{"text":"Wishing you a","id":"219faf66-34f2-4cb5-b9ec-a999de89ea41","type":"text","settings":{"font_family":"rum-raisin-regular","is_dragged":1,"is_selected":1,"font_size":"58","font_color":"#357aa0","text_align":"left","font_style":"normal","text_decoration":"none","font_weight":"normal","editable":1,"text_space":"0.02","line_height":"1.8","rotate":"0deg","text_transform":"none","z_index":"90","responsive_text_size":"20.59","height":"auto","width":"100%","left":"22.41244935666763","top":"63.19013490738352"}},{"id":"617b781f-268e-400a-a8cf-78f0912149e9","type":"text","text":"SHARKTASTIC","settings":{"font_family":"rum-raisin-regular","is_dragged":1,"is_selected":0,"font_size":"73","font_color":"#ba881c","text_align":"left","font_style":"normal","text_decoration":"none","font_weight":"normal","editable":1,"text_space":"0.02","line_height":"1.8","rotate":"0deg","text_transform":"uppercase","z_index":"90","responsive_text_size":"25.915","height":"auto","width":"100%","left":"18.98535968761829","top":"70.7285768348637"}},{"id":"84580a13-835e-4c56-b1cd-ae44e9d350f9","type":"text","text":"BIRTHDAY","settings":{"font_family":"rum-raisin-regular","is_dragged":1,"is_selected":0,"font_size":"73","font_color":"#357aa0","text_align":"left","font_style":"normal","text_decoration":"none","font_weight":"normal","editable":1,"text_space":"0.02","line_height":"1.8","rotate":"0deg","text_transform":"uppercase","z_index":"90","responsive_text_size":"25.915","height":"auto","width":"100%","left":"29.062719443460093","top":"80.58422804681953"}}],"images":[],"media":[]},"left":{"settings":{"background_image":null},"texts":[{"id":"bfa3fb0e-29bc-419b-8b42-b21d455c23cc","type":"text","text":"Memories to Cherish","settings":{"font_family":"crimson-text-regular","is_dragged":1,"is_selected":0,"font_size":"18","font_color":"#d84f4f","text_align":"center","font_style":"normal","text_decoration":"none","font_weight":"normal","editable":1,"text_space":"0.05em","line_height":"1.5","rotate":"0deg","text_transform":"none","z_index":"10","responsive_text_size":"9.63","height":"auto","width":"100%","left":"35","top":"70"}}],"media":[],"images":[]},"right":{"settings":{"background_image":null},"texts":[{"id":"439604a0-d0e0-4886-8251-e0992eba9803","type":"text","text":"A Day to Remember","settings":{"font_family":"crimson-text-regular","is_dragged":1,"is_selected":0,"font_size":"20","font_color":"#d84f4f","text_align":"center","font_style":"normal","text_decoration":"none","font_weight":"normal","editable":1,"text_space":"0.05em","line_height":"1.5","rotate":"0deg","text_transform":"none","z_index":"5","responsive_text_size":"20","height":"auto","width":"100%","left":"35","top":"60"}}],"media":[],"images":[]},"back":{"settings":{"background_image":null},"texts":[],"images":[],"media":[]}}'
      });
      var dio = Dio();
      var response = await dio.request(
        'https://dev.inviteflare.com/api/v1/invitations/cards/customize',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    }
    catch(e,st){
      if (e is DioException) {
        print("yes dioecepiton");
        print("Status: ${e.response?.statusCode}");
        print("Body: ${e.response?.data}");
      }
      print("no dioecepiton");
      print("updateCardApiError  = $e ##  $st");
    }

  }


  //aman new
  Future<void> updateCustomizeCardApi2(String cardId) async {
    try {
      isLoading.value = true;

      // 1️⃣ Convert your in-memory model to a JSON map
      final Map<String, dynamic> cDataMap = {
        'front': {
          'settings': {
            'background_image': backgroundImageURL.value,
          },
          'texts': items.map((item) => {
              'id': item.key.toString(),
              'type': 'text',
              'text': item.text,
              'settings': {
                'font_family': item.fontFamily,
                'font_size': item.fontSize.toString(),
                'font_color': '#${item.color.value.toRadixString(16).substring(2)}',
                'font_weight': item.isBold ? 'bold' : 'normal',
                'font_style': item.isItalic ? 'italic' : 'normal',
                'text_align': 'left',
                'text_decoration': 'none',
                'editable': 1,
                'is_dragged': 1,
                'is_selected': 0,
                'text_space': '0.02',
                'line_height': '1.8',
                'rotate': '0deg',
                'text_transform': 'none',
                'z_index': '90',
                'height': 'auto',
                'width': '100%',
                // convert back to % positions relative to rendered area
                // "left": ((item.left / renderedWidth) * 100).toString(),
                // "top": ((item.top / renderedHeight) * 100).toString(),
              },
            }).toList(),
          'images': [],
          'media': [],
        },
        'left': {
          'settings': {'background_image': null},
          'texts': [],
          'images': [],
          'media': [],
        },
        'right': {
          'settings': {'background_image': null},
          'texts': [],
          'images': [],
          'media': [],
        },
        'back': {
          'settings': {'background_image': null},
          'texts': [],
          'images': [],
          'media': [],
        },
      };

      // 2️⃣ Wrap it into outer structure required by API
      final Map<String, dynamic> body = {
        'cId': cardId,
        'type': 'greeting', // or "greeting"
        'cData': jsonEncode(cDataMap), // must be stringified JSON
      };

      // 3️⃣ Send PATCH request
      final response = await DioClient(Dio())
          .patch('v1/invitations/cards/customize', data: body, skipAuth: false);
      userCid= response['cId']??'zDUiJVHc_MtR';

    } catch (e, st) {
      dev.log('❌ PATCH error: $e\n$st');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateCardApi3({
    required String cardId,
    required String type, // "invitation" or "greeting"
    required Map<String, dynamic> cardData, // Your modified card data
  }) async {
    try {
      // Initialize Dio client (your existing class)
      final dioClient = DioClient(Dio());

      // Encode cData (your full card layout JSON) as a string
      final String cDataString = json.encode(cardData);

      // Build request body as per API requirement
      final Map<String, dynamic> body = {
        'cId': cardId,
        'type': type,
        'cData': cDataString,
      };

      debugPrint('📦 PATCH Request Body: ${json.encode(body)}');

      // Make PATCH call using your DioClient
      final response = await dioClient.patch(
        'v1/invitations/cards/customize/$cardId',
        data: json.encode(body),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Log and check success
      debugPrint('✅ PATCH Response: $response');

      // You can adjust this condition if the API returns a specific success structure
      return true;
    } catch (e, st) {
      debugPrint('❌ updateCardApi Error: $e\n$st');
      return false;
    }
  }









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

  void updateTextProperty(
    EditableTextItem item, {
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
      RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
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
