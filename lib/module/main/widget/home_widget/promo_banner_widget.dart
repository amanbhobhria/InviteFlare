import 'package:flutter/material.dart';
import 'package:invite_flare/core/mock/mock_data.dart';
import 'package:if_loop_components/if_loop_components.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IFImageView(
          url: MockData.promoBanner,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 1.4,
          fit: BoxFit.cover,
          borderRadius: 15,
        ),
      );
}
