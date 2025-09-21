/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';

import '../../../export.dart';

toast(message, {int seconds = 1}) => Get.snackbar(
      'Rizewell',
      '$message',
      borderRadius: 6.0,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: Duration(seconds: seconds),
      backgroundColor: colorAppGradient1,
      margin: EdgeInsets.zero,
      colorText: colorVioletM,
      duration: Duration(milliseconds: 1900),
      backgroundGradient: const LinearGradient(colors: [colorAppGradient1, colorAppGradient2]),
    );
