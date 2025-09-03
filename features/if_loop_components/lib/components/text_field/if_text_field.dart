part of '../../if_loop_components.dart';

class IFTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final void Function(String)? onChanged;

  const IFTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      onTap: onTap,
      readOnly: onTap != null,
      style: IFTextStyles.style.textStyle(
        textSize: IFTextSize.S,
        textWeight: IFTextWeight.regular,
        textStyle: IFTextColors.HEADING,
      ),
      decoration: InputDecoration(
        labelText: hintText,
        floatingLabelStyle: IFTextStyles.style.textStyle(
          textSize: IFTextSize.M,
          textWeight: IFTextWeight.regular,
          textStyle:
              errorText != null ? IFTextColors.ERROR : IFTextColors.BRAND,
        ),
        labelStyle: IFTextStyles.style.textStyle(
          textSize: IFTextSize.M,
          textWeight: IFTextWeight.regular,
          textStyle: IFTextColors.DESCRIPTION,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: IFColors.BRAND,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: IFColors.BRAND,
            width: 1,
          ),
        ),
        errorText: errorText,
        errorStyle: IFTextStyles.style.textStyle(
          textSize: IFTextSize.xS,
          textWeight: IFTextWeight.regular,
          textStyle: IFTextColors.ERROR,
        ),
      ),
    );
  }
}
