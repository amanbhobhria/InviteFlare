import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/core.dart';

mixin SignUpDialogs {
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogUtils(
        title: title,
        content: IFText(
          text: subTitle,
          textSize: IFTextSize.S,
          textAlign: TextAlign.center,
        ),
        actions: [
          IFButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
            buttonStyle: IFButtonStyle.TEXT,
            buttonSize: IFButtonSize.MIN,
          ),
        ],
      ),
    );
  }
}
