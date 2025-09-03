import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';

class SloganWrapper extends StatelessWidget {
  const SloganWrapper({super.key});

  @override
  Widget build(BuildContext context) => const _SloganWrapper();
}

class _SloganWrapper extends StatelessWidget {
  const _SloganWrapper();

  @override
  Widget build(BuildContext context) => const SloganView(

        heading: 'Save Environment',
        sloganText: '''
Green leaves whisper, life they bring, Save the trees, let nature sing!''',
      );
}


