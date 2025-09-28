import 'package:flutter_svg/flutter_svg.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';

class CategoryTile extends BaseStatelessWidget {
  final String name;
  final String icon;
  final Color cardColor;
  final Function() onTap;
  const CategoryTile({
    super.key,
    required this.name,
    required this.onTap,
    required this.icon,
    required this.cardColor,
  });

  @override
  Widget buildWidget(BuildContext context) => SizedBox(
        child: IFCard(
          height: 130,
          width: 120,
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          surfaceColor: cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.network(
                icon,
                width: 50,
                height: 50,
              ),
              const IFSpace(
                space: IFSpaces.xxS,
              ),
              Flexible(
                child: IFText(
                  text: name,
                  textSize: IFTextSize.S,
<<<<<<< Updated upstream
                  textWeight: IFTextWeight.semiBold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
=======
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textWeight: IFTextWeight.semiBold,
                  textAlign: TextAlign.center,
>>>>>>> Stashed changes
                ),
              )
            ],
          ),
        ),
      );
}
