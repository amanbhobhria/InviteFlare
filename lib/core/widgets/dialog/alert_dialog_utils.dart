import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';

class AlertDialogUtils extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget>? actions;
  final bool isDismissible;
  final Color? backgroundColor;
  final double? borderRadius;

  const AlertDialogUtils({
    super.key,
    required this.title,
    this.content,
    this.actions,
    this.isDismissible = true,
    this.backgroundColor,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).dialogBackgroundColor,
        child: PopScope(
          canPop: isDismissible,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IFHeading(
                  text: title,
                ),
                const IFSpace(
                  space: IFSpaces.xS,
                ),
                // Content
                if (content != null) content!,
                const IFSpace(),
                // Actions
                if (actions != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: actions!,
                  ),
              ],
            ),
          ),
        ),
      );
}
