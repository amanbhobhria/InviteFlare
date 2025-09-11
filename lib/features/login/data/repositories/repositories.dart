import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/network/api_handler.dart';

import 'package:invite_flare/features/login/constants.dart';

@injectable
class LoginRepository {
  final APIHandler _apiHandler;

  LoginRepository({required APIHandler apiHandler}) : _apiHandler = apiHandler;

  Future<Response> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await _apiHandler.post(Constants.login, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}





