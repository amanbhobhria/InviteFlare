import 'package:flutter/material.dart';
import 'package:invite_flare/app/app_constants/screen_constants.dart';
import 'package:invite_flare/core/widgets/dialog/snack_bar_utils.dart';

abstract class BaseStatelessWidget extends StatelessWidget
    with ScreenConstants, SnackBarUtils {
  const BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) => buildWidget(context);

  @protected
  Widget buildWidget(BuildContext context);
}
