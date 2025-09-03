part of '../../if_loop_components.dart';

class IFSearchField extends StatelessWidget {
  final String hint;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final bool isEnabled;
  final TextEditingController? controller;
  final Function()? onTapSearch;
  final Function(String)? onChanged;
  final Widget? suffix;

  const IFSearchField({
    super.key,
    required this.hint,
    this.controller,
    this.prefixIcon,
    this.onTapSearch,
    this.isEnabled = true,
    this.focusNode,
    this.onChanged,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    bool enableSuffixIcon = controller != null;
    enableSuffixIcon = enableSuffixIcon ? controller!.text.isNotEmpty : false;
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      style: IFTextStyles.style.textStyle(
        textSize: IFTextSize.M,
        textWeight: IFTextWeight.regular,
        textStyle: IFTextColors.HEADING,
      ),
      onTap: onTapSearch,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: IFTextStyles.style.textStyle(
          textSize: IFTextSize.M,
          textWeight: IFTextWeight.regular,
          textStyle: IFTextColors.HINT,
        ),
        suffixIcon: enableSuffixIcon ? suffix : null,
        contentPadding: prefixIcon == null
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
            : null,
        enabled: isEnabled,
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: IFColors.DESCRIPTION,
              width: 1.2,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(30.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
