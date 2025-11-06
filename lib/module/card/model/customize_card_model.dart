import 'dart:convert';
import 'package:flutter/material.dart';

class CustomizeCardModel {
  dynamic cardId;
  Settings? settings;
  List<TextItemModel>? texts;

  CustomizeCardModel({
    this.cardId,
    this.settings,
    this.texts,
  });

  factory CustomizeCardModel.fromJson(Map<String, dynamic> json) => CustomizeCardModel(
      cardId: json['cId'] ?? json['card_id'],
      settings: json['settings'] != null
          ? Settings.fromJson(json['settings'])
          : null,
      texts: (json['texts'] as List<dynamic>?)
          ?.map((e) => TextItemModel.fromJson(e))
          .toList() ??
          [],
    );

  Map<String, dynamic> toJson() => {
    'cId': cardId,
    'settings': settings?.toJson(),
    'texts': texts?.map((e) => e.toJson()).toList(),
  };
}

class Settings {
  dynamic backgroundImage;

  Settings({this.backgroundImage});

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    backgroundImage: json['background_image'],
  );

  Map<String, dynamic> toJson() => {
    'background_image': backgroundImage,
  };
}

class TextItemModel {
  dynamic id;
  dynamic text;
  TextSettings? settings;

  TextItemModel({
    this.id,
    this.text,
    this.settings,
  });

  factory TextItemModel.fromJson(Map<String, dynamic> json) => TextItemModel(
    id: json['id'],
    text: json['text'],
    settings: json['settings'] != null
        ? TextSettings.fromJson(json['settings'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'settings': settings?.toJson(),
  };
}
class TextSettings {
  String? fontFamily;
  String? fontColor;
  String? fontStyle;
  String? fontWeight;
  String? textAlign;
  String? textDecoration;
  String? textTransform;
  double? fontSize;
  double? left;
  double? top;
  double? width;
  double? height;
  double? lineHeight;
  double? textSpace;
  String? rotate;
  int? zIndex;

  TextSettings({
    this.fontFamily,
    this.fontColor,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.textDecoration,
    this.textTransform,
    this.fontSize,
    this.left,
    this.top,
    this.width,
    this.height,
    this.lineHeight,
    this.textSpace,
    this.rotate,
    this.zIndex,
  });

  factory TextSettings.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) {
        final cleaned = value.replaceAll(RegExp(r'[^0-9.\-]'), '');
        return double.tryParse(cleaned);
      }
      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        final cleaned = value.replaceAll(RegExp(r'[^0-9\-]'), '');
        return int.tryParse(cleaned);
      }
      return null;
    }

    return TextSettings(
      fontFamily: json['font_family']?.toString(),
      fontColor: json['font_color']?.toString(),
      fontStyle: json['font_style']?.toString(),
      fontWeight: json['font_weight']?.toString(),
      textAlign: json['text_align']?.toString(),
      textDecoration: json['text_decoration']?.toString(),
      textTransform: json['text_transform']?.toString(),
      fontSize: parseDouble(json['font_size']),
      left: parseDouble(json['left']),
      top: parseDouble(json['top']),
      width: parseDouble(json['width']),
      height: parseDouble(json['height']),
      lineHeight: parseDouble(json['line_height']),
      textSpace: parseDouble(json['text_space']),
      rotate: json['rotate']?.toString(),
      zIndex: parseInt(json['z_index']),
    );
  }

  Map<String, dynamic> toJson() => {
    'font_family': fontFamily,
    'font_color': fontColor,
    'font_style': fontStyle,
    'font_weight': fontWeight,
    'text_align': textAlign,
    'text_decoration': textDecoration,
    'text_transform': textTransform,
    'font_size': fontSize,
    'left': left,
    'top': top,
    'width': width,
    'height': height,
    'line_height': lineHeight,
    'text_space': textSpace,
    'rotate': rotate,
    'z_index': zIndex,
  };
}



// class TextSettings {
//   dynamic left;
//   dynamic top;
//   dynamic fontSize;
//   dynamic fontFamily;
//   dynamic fontWeight;
//   dynamic fontStyle;
//   dynamic fontColor;
//
//   TextSettings({
//     this.left,
//     this.top,
//     this.fontSize,
//     this.fontFamily,
//     this.fontWeight,
//     this.fontStyle,
//     this.fontColor,
//   });
//
//   factory TextSettings.fromJson(Map<String, dynamic> json) => TextSettings(
//     left: (json['left'] as num?)?.toDouble(),
//     top: (json['top'] as num?)?.toDouble(),
//     fontSize: (json['font_size'] as num?)?.toDouble(),
//     fontFamily: json['font_family'],
//     fontWeight: json['font_weight'],
//     fontStyle: json['font_style'],
//     fontColor: json['font_color'],
//   );
//
//   Map<String, dynamic> toJson() => {
//     'left': left,
//     'top': top,
//     'font_size': fontSize,
//     'font_family': fontFamily,
//     'font_weight': fontWeight,
//     'font_style': fontStyle,
//     'font_color': fontColor,
//   };
// }
