import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/core/mock/mock_data.dart';

class PromoBannerWrapper extends StatelessWidget {
  const PromoBannerWrapper({super.key});

  @override
  Widget build(BuildContext context) => const _PromoBannerWrapper();
}

class _PromoBannerWrapper extends StatelessWidget {
  const _PromoBannerWrapper();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IFImageView(
          url: MockData.promoBanner,
          width: context.width,
          height: context.width / 1.4,
          fit: BoxFit.cover,
          borderRadius: 15,
        ),
      );
}
