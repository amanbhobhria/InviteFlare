part of '../../if_loop_components.dart';

class IFButton extends StatelessWidget {
  final String text;
  final IFButtonType buttonType;
  final IFButtonStyle buttonStyle;
  final IFButtonSize buttonSize;
  final Widget? icon;
  final bool isLoading;
  final void Function()? onPressed;

  const IFButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.buttonSize = IFButtonSize.DEFAULT,
    this.buttonStyle = IFButtonStyle.DEFAULT,
    this.buttonType = IFButtonType.PRIMARY,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: buttonSize == IFButtonSize.MIN ? null : size.width,
      height: 52,
      child: buttonType == IFButtonType.GOOGLE
          ? google()
          : buttonType == IFButtonType.FACEBOOK
              ? faceBook()
              : TextButton(
                  style: getButtonStyle(
                    style: buttonStyle,
                    type: buttonType,
                  ),
                  onPressed: onPressed,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: buttonSize == IFButtonSize.MIN ? 20.0 : 0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: buttonStyle == IFButtonStyle.DEFAULT
                                ? IFColors.WHITE
                                : IFColors.BRAND,
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (icon != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: icon!,
                                ),
                              Text(
                                text,
                                style: TextStyle(
                                  fontSize: textFontSize(
                                    textSize: IFTextSize.M,
                                  ),
                                  fontWeight: fontWeight(
                                    textWeight:
                                        buttonStyle == IFButtonStyle.TEXT
                                            ? IFTextWeight.regular
                                            : IFTextWeight.semiBold,
                                  ),
                                  color: textColors(
                                      textColor: getTextColor(
                                    style: buttonStyle,
                                    type: buttonType,
                                  )),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
    );
  }

  ButtonStyle getButtonStyle({
    required IFButtonStyle style,
    required IFButtonType type,
  }) {
    return switch (style) {
      IFButtonStyle.DEFAULT => ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            type == IFButtonType.PRIMARY ? IFColors.BRAND : IFColors.HEADING,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(type == IFButtonType.PRIMARY ? 10 : 30),
            ),
          ),
        ),
      IFButtonStyle.OUTLINE => ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(IFColors.TRANSPARENT),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(type == IFButtonType.PRIMARY ? 10 : 30),
              side: BorderSide(color: IFColors.BLACK_LIGHT),
            ),
          ),
        ),
      IFButtonStyle.TEXT => ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(type == IFButtonType.PRIMARY ? 10 : 30),
            ),
          ),
        ),
    };
  }

  IFTextColors getTextColor({
    required IFButtonStyle style,
    required IFButtonType type,
  }) {
    if (style == IFButtonStyle.DEFAULT) {
      if (type == IFButtonType.PRIMARY) {
        return IFTextColors.WHITE;
      } else {
        return IFTextColors.WHITE;
      }
    } else {
      if (type == IFButtonType.PRIMARY) {
        return IFTextColors.BRAND;
      } else {
        return IFTextColors.HEADING;
      }
    }
  }

  Widget google() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(IFColors.WHITE),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/png/google_logo.png',
            height: 22,
            width: 18,
          ),
          const IFSpace(
            direction: IFSpaceDirection.HORIZONTAL,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: textFontSize(
                textSize: IFTextSize.M,
              ),
              fontWeight: fontWeight(
                textWeight: IFTextWeight.semiBold,
              ),
              color: IFColors.DESCRIPTION,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget faceBook() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(IFColors.FACEBOOK),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/png/facebook.png',
            height: 24,
            width: 24,
          ),
          const IFSpace(
            direction: IFSpaceDirection.HORIZONTAL,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: textFontSize(
                textSize: IFTextSize.M,
              ),
              fontWeight: fontWeight(
                textWeight: IFTextWeight.semiBold,
              ),
              color: IFColors.WHITE,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
