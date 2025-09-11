import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class SaveProfile extends ProfileEvent {
  final String name;
  final String email;
  final String phone;
  final bool twoFactor;
  final String? profileImage;

  SaveProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.twoFactor,
    this.profileImage,
  });

  @override
  List<Object?> get props => [name, email, phone, twoFactor, profileImage];
}
