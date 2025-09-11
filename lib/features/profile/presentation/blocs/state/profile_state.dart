import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final bool loading;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;
  final bool twoFactor;
  final String? error;
  final bool success;

  const ProfileState({
    this.loading = false,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.twoFactor = false,
    this.error,
    this.success = false,
  });

  ProfileState copyWith({
    bool? loading,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    bool? twoFactor,
    String? error,
    bool? success,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      twoFactor: twoFactor ?? this.twoFactor,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props =>
      [loading, name, email, phone, profileImage, twoFactor, error, success];
}
