part of 'social_media_bloc.dart';

sealed class SocialMediaEvent extends Equatable {
  const SocialMediaEvent();
}

final class SocialMediaSubmit extends SocialMediaEvent {
  final SocialMediaType socialMediaType;

  const SocialMediaSubmit({required this.socialMediaType});

  @override
  List<Object?> get props => [socialMediaType];
}
