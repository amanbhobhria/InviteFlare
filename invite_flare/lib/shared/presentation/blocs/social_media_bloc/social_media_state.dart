part of 'social_media_bloc.dart';

sealed class SocialMediaState extends Equatable {
  const SocialMediaState();
}

final class SocialMediaInitial extends SocialMediaState {
  @override
  List<Object> get props => [];
}

final class SocialMediaLoading extends SocialMediaState {
  @override
  List<Object> get props => [];
}

final class SocialMediaSuccess extends SocialMediaState {
  @override
  List<Object> get props => [];
}

final class SocialMediaError extends SocialMediaState {
  final String message;

  const SocialMediaError({required this.message});
  @override
  List<Object> get props => [message];
}
