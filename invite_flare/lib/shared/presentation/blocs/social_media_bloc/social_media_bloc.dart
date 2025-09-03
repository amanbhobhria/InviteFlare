import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/shared/domain/domain.dart';

part 'social_media_event.dart';
part 'social_media_state.dart';

@injectable
class SocialMediaBloc extends Bloc<SocialMediaEvent, SocialMediaState> {
  final FacebookSignInUseCase facebookSignInUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  SocialMediaBloc({
    required this.googleSignInUseCase,
    required this.facebookSignInUseCase,
  }) : super(SocialMediaInitial()) {
    on<SocialMediaSubmit>((event, emit) {
      // TODO: implement event handler
    });
  }
}
