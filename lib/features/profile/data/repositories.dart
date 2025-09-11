import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/features/login/constants.dart';


@injectable
class ProfileRepository {
  final String baseUrl;
  final TokenService _tokenService;

  ProfileRepository(this.baseUrl, this._tokenService);

  Future<http.Response> getProfile() async {
    final token = await _tokenService.getAccessToken();
    return http.get(
      Uri.parse('$baseUrl${Constants.getProfile}'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<http.Response> updateProfile(Map<String, dynamic> body) async {
    final token = await _tokenService.getAccessToken();
    return http.post(
      Uri.parse('$baseUrl${Constants.updateProfile}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}



//
//
//
// abstract class IProfileRepository {
//   Future<http.Response> getProfile();
//   Future<http.Response> updateProfile(Map<String, dynamic> body);
// }
//
//
//
//
// @LazySingleton(as: IProfileRepository)
// class ProfileRepository implements IProfileRepository {
//   final String baseUrl;
//   final TokenService _tokenService;
//
//   ProfileRepository(this.baseUrl, this._tokenService);
//
//   @override
//   Future<http.Response> getProfile() async {
//     final token = await _tokenService.getAccessToken();
//     return await http.get(
//       Uri.parse('$baseUrl${Constants.getProfile}'),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//   }
//
//   @override
//   Future<http.Response> updateProfile(Map<String, dynamic> body) async {
//     final token = await _tokenService.getAccessToken();
//     return await http.post(
//       Uri.parse('$baseUrl${Constants.updateProfile}'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(body),
//     );
//   }
// }
//





//
// @injectable
// class ProfileRepository {
//   final String baseUrl;
//   final TokenService _tokenService;
//
//   ProfileRepository(this.baseUrl, this._tokenService);
//
//   Future<http.Response> getProfile() async {
//     final token = await _tokenService.getAccessToken();
//     return await http.get(
//       Uri.parse('$baseUrl${Constants.getProfile}'),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//   }
//
//   Future<http.Response> updateProfile(Map<String, dynamic> body) async {
//     final token = await _tokenService.getAccessToken();
//     return await http.post(
//       Uri.parse('$baseUrl${Constants.updateProfile}'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(body),
//     );
//   }
// }
//
