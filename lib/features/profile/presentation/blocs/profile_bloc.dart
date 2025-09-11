import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/features/profile/data/repositories.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/profile_events.dart';
import 'package:invite_flare/features/profile/presentation/blocs/state/profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<SaveProfile>(_onSaveProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(loading: true));
    try {

      print("profile _onLoadProfile ");
      final response = await _repository.getProfile();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(state.copyWith(
          loading: false,
          name: data['name'],
          email: data['email'],
          phone: data['contact'],
          profileImage: data['profile_image'],
          twoFactor: data['two_factor'] == 1,
        ));
      } else {
        emit(state.copyWith(
            loading: false, error: 'Failed to load profile data'));
      }
    } catch (e) {

      print("profile _onLoadProfile e = $e");
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onSaveProfile(
      SaveProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final body = {
        'name': event.name,
        'email': event.email,
        'contact': event.phone,
        'two_factor': event.twoFactor ? 1 : 0,
        'profile_image': event.profileImage ?? state.profileImage,
      };

      final response = await _repository.updateProfile(body);
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(state.copyWith(
          loading: false,
          success: true,
          error: null,
          name: event.name,
          email: event.email,
          phone: event.phone,
          profileImage: event.profileImage ?? state.profileImage,
          twoFactor: event.twoFactor,
        ));
      }



      // if (response.statusCode == 200) {
      //   emit(state.copyWith(
      //       loading: false, success: true, error: null, ...body));
      // }
      else {
        emit(state.copyWith(loading: false, error: decoded['message']));
      }
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
