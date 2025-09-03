import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/home/presentation/blocs/expandable_card_bloc/expandable_card_bloc.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';

class ExpandableCardWrapper extends StatelessWidget {
  const ExpandableCardWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<ExpandableCardBloc>()
          ..add(
            FetchExpandableCardEvent(),
          ),
        child: const _ExpandableCardWrapper(),
      );
}

class _ExpandableCardWrapper extends BaseStatelessWidget {
  const _ExpandableCardWrapper();

  @override
  Widget buildWidget(BuildContext context) =>
      BlocBuilder<ExpandableCardBloc, ExpandableCardState>(
        builder: (context, state) => switch (state) {
          ExpandableCardInitial() ||
          ExpandableCardLoadingState() =>
            const Center(
              child: CircularProgressIndicator(),
            ),
          ExpandableCardSuccessState() => ExpandableCardView(
              heading: state.expandableCard['heading'],
              description: state.expandableCard['description'],
              invitationCards: state.expandableCard['cards'],
            ),
          ExpandableCardErrorState() => const SizedBox.shrink(),
        },
      );
}
