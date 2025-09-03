import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/home/presentation/blocs/explainer_section_bloc/explainer_section_bloc.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';

class ExplainerSectionWrapper extends BaseStatelessWidget {
  const ExplainerSectionWrapper({super.key});

  @override
  Widget buildWidget(BuildContext context) => BlocProvider(
        create: (context) => getIt<ExplainerSectionBloc>()
          ..add(
            FetchExplainerSectionEvent(),
          ),
        child: const _ExplainerSectionWrapper(),
      );
}

class _ExplainerSectionWrapper extends StatelessWidget {
  const _ExplainerSectionWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ExplainerSectionBloc, ExplainerSectionState>(
        builder: (context, state) => switch (state) {
          ExplainerSectionInitial() ||
          ExplainerSectionLoadingState() =>
            const Center(
              child: CircularProgressIndicator(),
            ),
          ExplainerSectionSuccessState() => ExplainerSectionView(
              heading: state.explainerSection['heading'],
              steps: state.explainerSection['section'],
            ),
          ExplainerSectionErrorState() => const SizedBox.shrink(),
        },
      );
}
