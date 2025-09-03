import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/network/api_handler.dart';
import 'package:invite_flare/features/category/constants.dart';

@injectable
class CategoryRepository {
  final APIHandler _apiHandler;

  CategoryRepository({required APIHandler apiHandler})
      : _apiHandler = apiHandler;

  Future<Response> getCardsByCategory(String category) async {
    try {
      final response = await _apiHandler.get(
          '${Constants.getCardsByCategory}/$category',
          queryParameters: {'sort': 'popular'});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllCategories() async {
    try {
      final response = await _apiHandler.get(Constants.getAllCategories);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
