
import 'package:invite_flare/core_2/core/values/app_colors.dart';

import '../../../export.dart';

class AssetImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? radiusAll;
  final double radiusTopRight;
  final double radiusTopLeft;
  final double radiusBottomRight;
  final double radiusBottomLeft;
  final double? imageHeight;
  final double? imageWidth;
  final BoxFit? imageFitType;
  final Color? color;
  final bool isGradient;

  AssetImageWidget(
      {Key? key,
      required this.imageUrl,
      this.radiusAll,
      this.radiusTopLeft = 0.0,
      this.radiusBottomRight = 0.0,
      this.radiusBottomLeft = 0.0,
      this.radiusTopRight = 0.0,
      this.imageHeight,
      this.imageWidth,
      this.isGradient = false,
      this.color,
      this.imageFitType = BoxFit.contain,
      der})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isGradient
        ? ClipRRect(
            borderRadius: radiusAll == null
                ? BorderRadius.only(
                    topRight: Radius.circular(radiusTopRight),
                    topLeft: Radius.circular(radiusTopLeft),
                    bottomLeft: Radius.circular(radiusBottomLeft),
                    bottomRight: Radius.circular(radiusBottomRight))
                : BorderRadius.circular(radiusAll!),
            child: Image(
              image: AssetImage(
                imageUrl,
              ),
              color: color,
              height: imageHeight,
              width: imageWidth,
              fit: imageFitType,
            ))
        : ClipRRect(
            borderRadius: radiusAll == null
                ? BorderRadius.only(
                    topRight: Radius.circular(radiusTopRight),
                    topLeft: Radius.circular(radiusTopLeft),
                    bottomLeft: Radius.circular(radiusBottomLeft),
                    bottomRight: Radius.circular(radiusBottomRight))
                : BorderRadius.circular(radiusAll!),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: [
                    colorAppGradient1, colorAppGradient2 // Gradient color 2
                  ],
                ).createShader(rect);
              },
              child: Image(
                image: AssetImage(
                  imageUrl,
                ),
                color: Colors.white,
                height: imageHeight,
                width: imageWidth,
                fit: imageFitType,
              ),
            ));
  }
}
