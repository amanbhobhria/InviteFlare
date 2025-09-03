part of '../../if_loop_components.dart';

class IFSpace extends StatelessWidget {
  final IFSpaces space;
  final IFSpaceDirection direction;

  const IFSpace({
    super.key,
    this.space = IFSpaces.M,
    this.direction = IFSpaceDirection.VERTICAL,
  });

  @override
  Widget build(BuildContext context) {
    return direction == IFSpaceDirection.HORIZONTAL
        ? SizedBox(
            width: getSpace(space: space),
          )
        : SizedBox(
            height: getSpace(space: space),
          );
  }
}
