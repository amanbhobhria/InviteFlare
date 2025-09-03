import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/network/api_handler.dart';
import 'package:invite_flare/features/search/constants.dart';

@injectable
class SearchRepository {
  final APIHandler _apiHandler;

  SearchRepository({required APIHandler apiHandler}) : _apiHandler = apiHandler;

  Future<Response> search(String query) async {
    try {
      final response = await _apiHandler
          .get(Constants.search, queryParameters: {'q': query});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
