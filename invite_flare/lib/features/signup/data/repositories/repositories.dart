import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/network/api_handler.dart';
import 'package:invite_flare/features/signup/constants.dart';

@injectable
class SignUpRepository {
  final APIHandler _apiHandler;

  SignUpRepository({required APIHandler apiHandler}) : _apiHandler = apiHandler;

  Future<Response> signUpUser(Map<String, dynamic> body) async {
    try {
      final response = await _apiHandler.post(Constants.signUp, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
