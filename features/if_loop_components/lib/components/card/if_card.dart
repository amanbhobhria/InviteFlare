part of '../../if_loop_components.dart';

class IFCard extends StatelessWidget {
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final double radius;
  final Color surfaceColor;
  final double? elevation;
  final Widget child;
  final Function()? onTap;

  const IFCard({
    super.key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.surfaceColor = Colors.white,
    this.elevation = 0,
    this.width,
    this.height,
    this.radius = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        elevation: elevation,
        color: surfaceColor,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
