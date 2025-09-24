import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:invite_flare/features/event_details/presentation/pages/event_details_page.dart';

/// Parses either a raw pixel value ("120") or a percentage ("50%")
/// against [total] pixels, returning the calculated pixel amount.
double _parseDimension(String? raw, double total) {
  if (raw == null) return 0;
  final str = raw.trim();
  // treat both "50" and "50%" as percent values
  final numberStr = str.endsWith('%') ? str.substring(0, str.length - 1) : str;
  final percent = double.tryParse(numberStr) ?? 0.0;
  return total * percent / 100.0;
}

String _mapWebFontToFlutter(String font) {
  switch (font) {
    case 'poppins-regular':
      return 'Poppins'; // Make sure it's in pubspec.yaml
    case 'dancing-script-normal':
      return 'DancingScript';
    default:
      return font; // fallback
  }
}

/// Inherited widget for passing the parent canvas size down the tree.
class _SizeInherited extends InheritedWidget {
  final Size parentSize;

  const _SizeInherited({required this.parentSize, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant _SizeInherited old) =>
      old.parentSize != parentSize;

  static Size of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_SizeInherited>();
    return inherited?.parentSize ?? MediaQuery.of(context).size;
  }
}

class SelectedItem {
  final Key key;
  final ItemType type;

  SelectedItem(this.key, this.type);
}

enum ItemType { text, image }

class CardCustomizePage extends StatefulWidget {
  final String cardId;

  const CardCustomizePage(this.cardId, {super.key});

  @override
  _CardCustomizePageState createState() => _CardCustomizePageState();
}

class _CardCustomizePageState extends State<CardCustomizePage> {
  final List<Widget> _items = [];
  Color? _backgroundColor;
  String? _backgroundImageURL;
  SelectedItem? _selectedItem;
  late BuildContext ctx;
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5ZDFjNGM1YS0yZDJiLTQ2OTItOGYyZi02M2VmNDcxMmJhMDYiLCJqdGkiOiIyZTE2NjM5OWMwOWNhNWJhYzgwZTBjZjU0MWRmNGI0ZGI5YzQ1ODZjNWI2MTA2NTE4M2RhYzM0MmVlYTIwYTE1MTM1YTZmOWQ4MTU5NDY0YSIsImlhdCI6MTc0ODI3Mjc4MS44OTIyODgsIm5iZiI6MTc0ODI3Mjc4MS44OTIyOSwiZXhwIjoxNzQ4Mjg3MTgxLjg3NDY5Miwic3ViIjoiNzciLCJzY29wZXMiOlsiKiJdfQ.qtSzWtqXjVJYgZdEuzDSx5g5rXV58OtfmblSzABGPkHXuX6FeWT3_AJMNpe7tQGPvFpKyxsXJ2QcuaB66LM4fiUCIHR_Usykt43N4p_xen7gXcuZkJIOuzrt-gm97EFtaJDpLN4ucrteuB6CUZZAQJMggbKJbmSBx86NOB9UkIHPHvBU_4wTJyKRyVQjGbzvie2BTOU5Z2ap75Zfu2HrlZJluXc6fHNfAs8WiT-z8y-6uhy2vwDm3F2-hI5cUyUbFqWhphuBOPj30D1bU97UuPbCf9l4jyCq1_DChH6z2GKoOOYYXNoWXnDgF9Gm3EdW1RQmQokD1x4S0j-uH6YRid8r0UX4nmYEGOXjKx4G74Az9xuSbPFFx0QfDbyEUVR62dF1SsINSKMyF6iD7f3l0biT0fWNLZHcqOixVMaFV6CVtwI3yi4qz0aWingbX6ZSim4-aMrb98z8EpmdEHUQt1DeCvQR8i3tS46D6qjJjmAxS6-Q_piX_JYwwI690Pg0wAhGL6_MaxpNIUyt2VlZ7Krl31BqTENNiwZs5G6O8-EfepSUv8qb4m4thTTVClWDZE4zBVwunJ5uXWyCT83JYz8i-bg8QcCNSejNxG25KWuD3qm_sYNuuGfu1WPeOfkizZQ0Xub-krBRrAxbx54SCdfI2xbemeacfyEM_hVQSds";
  final GlobalKey _repaintKey = GlobalKey();

  Future<void> sendEventInfo(String cardId) async {
    final url = Uri.parse(
      'https://dev.inviteflare.com/api/v1/invitations/user/eventinfo',
    );

    final payload = {
      "cId": cardId,
      "event_title": "Saved From App Again",
      "event_datetime": "2029-05-09 00:00:00",
      "event_hosted_by": "Gaurav Narula",
      "is_virtual": 0,
      "event_address": "47 Elysian Fields Circle",
      "location_name": "John Apartment",
      "virtual_event_link": null,
      "description": "Lorem Ipsum 2",
      "collect_rsvp": 1,
      "confetti": 0,
      "rsvp_deadline": "2029-05-08 00:00:00",
      "allow_additional_guest": 0,
      "guest_limit": 1,
      "gift_registry": [
        {"title": "Amazon", "url": "https://amazon.com/registry"},
        {"title": "Walmart", "url": "https://walmart.com/registry"},
        {"title": "ebay", "url": "https://ebay.com/registry"}
      ],
      "custom_invitation_message": "Saved from App Again",
      "send_reminders": 1,
      "reminder_schedule": "1 day before",
      "custom_reminder_date": null,
      "schedule_at": null
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      dev.log('Event Info Status: ${response.statusCode}');
      dev.log('Event Info Response: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event info updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update event info')),
        );
      }
    } catch (e) {
      print('Event info error: $e');
    }
  }

  Future<void> saveScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Instead of saving to gallery, output base64 string
      final base64Image = base64Encode(pngBytes);
      print('BASE64 SCREENSHOT:\n$base64Image');
    } catch (e) {
      print('Error saving screenshot: $e');
    }
  }

  Future<void> uploadScreenshotImage(String cardId) async {
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();
      final base64Image = base64Encode(pngBytes);

      final payload = jsonEncode({
        'cId': cardId,
        'files': 'data:image/jpeg;base64,$base64Image',
      });

      final url = Uri.parse(
        'https://dev.inviteflare.com/api/v1/invitations/cards/customize/image/upload',
      );

      final response = await http.patch(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: payload,
      );

      dev.log('Upload Status: ${response.statusCode}');
      dev.log('Upload Response: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
        sendEventInfo(jsonResponse['cId']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.body}')),
        );
      }
    } catch (e) {
      print('Upload error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _updateJsonData(Map<String, dynamic> payload) async {
    final url = Uri.parse(
      'https://dev.inviteflare.com/api/v1/invitations/cards/customize',
    );
    final body = jsonEncode(payload);
    dev.log('PATCH body:$body');
    final response = await http.patch(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    dev.log('Status: ${response.statusCode}');
    dev.log('Response: ${response.body}');
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dev.log('Saved card: ${jsonResponse['cId']}');
      uploadScreenshotImage(jsonResponse['cId']);
    }
    if (response.statusCode != 200) {
      throw Exception('API error ${response.statusCode}: ${response.body}');
    }
  }

  void saveJSON() {
    final cDataMap = {
      'settings': {
        'background_image': _backgroundImageURL ?? '',
      },
      'texts': _items.whereType<EditableTextItem>().map((item) {
        final keyValue = (item.key as ValueKey).value.toString();
        return {
          'id': keyValue,
          'type': 'text',
          'text': item.text,
          'settings': item.textData,
        };
      }).toList(),
      'images': [],
    };

    final payload = {
      'cId': widget.cardId,
      'type': 'invitation',
      'cData': jsonEncode(cDataMap),
    };

    _updateJsonData(payload);
  }

  Future<void> _loadJsonData() async {
    try {
      final url = Uri.parse(
        'https://dev.inviteflare.com/api/v1/invitations/cards/customize/${widget.cardId}',
      );
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final dataFromApi = jsonDecode(response.body);
        final Map<String, dynamic> data = json.decode(dataFromApi['card']);

        // background image
        _backgroundImageURL = data['settings']['background_image'] ?? '';
        // text items
        for (final textData in data['texts']) {
          _items.add(
            _createTextItem(
              textData['id'],
              textData['text'],
              textData['settings'],
            ),
          );
        }
        setState(() {});
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _addText() async {
    final randomId =
        List.generate(6, (_) => Random().nextInt(36).toRadixString(36)).join();
    setState(() {
      _items.add(
        _createTextItem(randomId, 'New Text', {
          'left': '10%',
          'top': '10%',
          'font_size': '24',
          'font_color': '#000000',
          'font_weight': 'normal',
          'font_style': 'normal',
          'font_family': 'Arial',
          'rotate': '0deg',
        }),
      );
    });
  }

  void _deleteItem() {
    setState(() {
      _items.removeWhere((el) => el.key == _selectedItem?.key);
      _selectedItem = null;
    });
  }

  void _selectItem(Key key, ItemType type) {
    setState(() => _selectedItem = SelectedItem(key, type));
  }

  Widget _createTextItem(
    String id,
    String text,
    Map<String, dynamic>? settings,
  ) =>
      EditableTextItem(
        key: ValueKey(id),
        text: text,
        textData: settings ?? {},
        onDelete: _deleteItem,
        onSelect: () => _selectItem(ValueKey(id), ItemType.text),
      );

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Editor'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: (){
            //saveJSON();
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventDetailsPage())
            );
           // context.go('/card_customize_screen');
          }),
          IconButton(icon: const Icon(Icons.text_fields), onPressed: _addText),
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              /* ... */
            },
          ),
          /*IconButton(
            icon: const Icon(Icons.camera_alt),
            tooltip: 'Save Screenshot',
            onPressed: uploadScreenshotImage,
          ),*/
        ],
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: RepaintBoundary(
            key: _repaintKey,
            child: SizedBox(
              width: 500,
              height: 700,
              child: _SizeInherited(
                parentSize: const Size(500, 700),
                child: Stack(
                  children: [
                    if (_backgroundImageURL != null)
                      Positioned.fill(
                        child: Image.network(_backgroundImageURL!,
                            fit: BoxFit.cover),
                      ),
                    if (_backgroundColor != null)
                      Positioned.fill(
                          child: Container(color: _backgroundColor)),
                    ..._items,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _selectedItem != null
          ? FloatingActionButton(
              onPressed: _deleteItem,
              backgroundColor: _selectedItem!.type == ItemType.text
                  ? Colors.blue
                  : Colors.green,
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }
}

class EditableTextItem extends StatefulWidget {
  String text;
  final Map<String, dynamic> textData;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  EditableTextItem({
    Key? key,
    required this.text,
    required this.textData,
    required this.onDelete,
    required this.onSelect,
  }) : super(key: key);

  @override
  _EditableTextItemState createState() => _EditableTextItemState();
}

class _EditableTextItemState extends State<EditableTextItem> {
  double _fontSize = 24.0;
  bool _isBold = false;
  bool _isItalic = false;
  Color _color = Colors.black;
  double _rotationAngle = 0.0;
  String _fontFamily = 'Arial';

  @override
  void initState() {
    super.initState();
    final data = widget.textData;
    _fontSize = double.tryParse(data['font_size']?.toString() ?? '') ?? 24.0;
    _isBold = data['font_weight'] == 'bold';
    _isItalic = data['font_style'] == 'italic';
    _fontFamily = _mapWebFontToFlutter(data['font_family'] ?? 'Arial');
    final hex =
        (data['font_color'] as String?)?.replaceFirst('#', '') ?? '000000';
    _color = Color(int.parse('0xFF$hex'));
    final rot = data['rotate']?.toString() ?? '0deg';
    final deg = rot.endsWith('deg')
        ? double.tryParse(rot.replaceAll('deg', '')) ?? 0
        : double.tryParse(rot) ?? 0;
    _rotationAngle = deg * pi / 180;
  }

  TextAlign _getTextAlign(String? align) {
    switch (align) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  double _getLineHeight(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 1.2;
    if (value is num) return value.toDouble();
    return 1.2;
  }

  TextDecoration _getDecoration(String? deco) {
    switch (deco) {
      case 'underline':
        return TextDecoration.underline;
      case 'line-through':
        return TextDecoration.lineThrough;
      default:
        return TextDecoration.none;
    }
  }

  String _applyTextTransform(String text, String? transform) {
    switch (transform) {
      case 'uppercase':
        return text.toUpperCase();
      case 'lowercase':
        return text.toLowerCase();
      default:
        return text;
    }
  }

  void _editTextProperties() {
    final ctl = TextEditingController(
      text: widget.text,
    );
    showModalBottomSheet(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctl,
                decoration: const InputDecoration(
                  labelText: 'Edit Text',
                ),
                onChanged: (v) => widget.text = v,
              ),
              DropdownButton<String>(
                value: _fontFamily,
                items: ['Arial', 'Roboto', 'Times New Roman', 'DancingScript','great-vibes-regular','josefin-sans-normal','luckiest-guy-regular','pacifico-regular']
                    .map(
                      (f) => DropdownMenuItem(
                        value: f,
                        child: Text(f),
                      ),
                    )
                    .toList(),
                onChanged: (f) => setState(() => _fontFamily = f!),
              ),
              Row(
                children: [
                  const Text('Bold'),
                  Checkbox(
                    value: _isBold,
                    onChanged: (v) => setState(() => _isBold = v!),
                  ),
                  const Text('Italic'),
                  Checkbox(
                    value: _isItalic,
                    onChanged: (v) => setState(() => _isItalic = v!),
                  ),
                ],
              ),
              TextButton(
                child: const Text('Pick Color'),
                onPressed: () {
                  showDialog(
                    context: ctx,
                    builder: (ctx2) => AlertDialog(
                      content: ColorPicker(
                        pickerColor: _color,
                        onColorChanged: (c) => setState(() => _color = c),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () => Navigator.pop(ctx2),
                        ),
                      ],
                    ),
                  );
                },
              ),
              DropdownButton<double>(
                value: _fontSize,
                items: List.generate(100, (i) => (i + 1).toDouble())
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text('${s.toInt()}px'),
                      ),
                    )
                    .toList(),
                onChanged: (s) => setState(() => _fontSize = s!),
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  widget.textData
                    ..['font_family'] = _fontFamily
                    ..['font_weight'] = _isBold ? 'bold' : 'normal'
                    ..['font_style'] = _isItalic ? 'italic' : 'normal'
                    ..['font_size'] = _fontSize.toString()
                    ..['font_color'] =
                        '#${_color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
                  setState(() {});
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parent = _SizeInherited.of(context);

    final dx = _parseDimension(
      widget.textData['left']?.toString(),
      parent.width,
    );
    final dy = _parseDimension(
      widget.textData['top']?.toString(),
      parent.height,
    );
    final unescape = HtmlUnescape();
    final displayText = unescape.convert(
      widget.text,
    );

    return Positioned(
      left: dx,
      top: dy,
      child: GestureDetector(
        onTap: widget.onSelect,
        onLongPress: _editTextProperties,
        onScaleUpdate: (details) {
          setState(() {
            final newX = dx + details.focalPointDelta.dx;
            final newY = dy + details.focalPointDelta.dy;
            final pctX = (newX / parent.width) * 100;
            final pctY = (newY / parent.height) * 100;
            widget.textData['left'] = '${pctX.toStringAsFixed(2)}%';
            widget.textData['top'] = '${pctY.toStringAsFixed(2)}%';
            _fontSize = (_fontSize * details.scale).clamp(12.0, 72.0);
            _rotationAngle += details.rotation;
            widget.textData['rotate'] =
                '${(_rotationAngle * 180 / pi).toStringAsFixed(1)}deg';
          });
        },
        child: Transform.rotate(
          angle: _rotationAngle,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: parent.width - dx),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                _applyTextTransform(
                  displayText,
                  widget.textData['text_transform'],
                ),
                textAlign: _getTextAlign(widget.textData['text_align']),
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: _fontSize,
                  height: _getLineHeight(widget.textData['line_height']),
                  color: _color,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: _getDecoration(
                    widget.textData['text_decoration'],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditableImageItem extends StatefulWidget {
  final File imageFile;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  EditableImageItem({
    Key? key,
    required this.imageFile,
    required this.onDelete,
    required this.onSelect,
  }) : super(key: key);

  @override
  _EditableImageItemState createState() => _EditableImageItemState();
}

class _EditableImageItemState extends State<EditableImageItem> {
  Offset _position = const Offset(100, 100);
  double _scale = 1.0;
  double _rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) => Positioned(
        left: _position.dx,
        top: _position.dy,
        child: GestureDetector(
          onTap: widget.onSelect,
          onScaleUpdate: (details) {
            setState(() {
              _position += details.focalPointDelta;
              _scale = (_scale * details.scale).clamp(0.5, 3.0);
              _rotationAngle += details.rotation;
            });
          },
          child: Transform.rotate(
            angle: _rotationAngle,
            child: Image.file(
              widget.imageFile,
              width: 200 * _scale,
              height: 200 * _scale,
            ),
          ),
        ),
      );
}
