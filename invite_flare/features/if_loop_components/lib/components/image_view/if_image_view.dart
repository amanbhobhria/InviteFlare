part of '../../if_loop_components.dart';

class IFImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? elevation;
  final BoxFit? fit;
  final Widget? errorWidget;

  const IFImageView({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.elevation,
    this.fit,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          //BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: elevation != null ? Colors.black45 : Colors.transparent,
              blurRadius: elevation ?? 0,
            ),
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      fadeInDuration: const Duration(milliseconds: 200),
      errorWidget: (context, url, error) =>
          errorWidget ?? const Icon(Icons.error),
    );
  }
}
