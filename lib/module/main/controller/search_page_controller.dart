import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart'
    show DioClient;
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/module/main/model/search_category_response_model.dart';

class SearchPageController extends GetxController {

  final searchController = TextEditingController();
  SearchCategoryResponseModel? searchResponse;

  // Observables
  var isLoading = false.obs;
  var searchResults = [].obs;
  var recentSearches = <String>[
    'Birthday',
    'christ',
    'wedd',
    'Christmas',
  ].obs;
  var errorMessage = ''.obs;

  void onRecentSearchTap(String query) {
    searchController.text = query;
    searchCategory(query);
  }



  Future<void> searchCategory(String query) async {


    if (query.isEmpty) {
      searchResponse = null; // 👈 clear previous results
      update();
      return;
    }


    try {
      isLoading = true.obs;
      update();

      DioClient dioClient = DioClient(Dio());
      await dioClient
          .get('v1/search', skipAuth: false, queryParameters: {"q": query})
          .then((value) {
        if (value != null) {
          searchResponse = SearchCategoryResponseModel.fromJson(value);
          debugPrint("Search Response: ${searchResponse?.data.length}");
        }
      }).onError((error, stackTrace) {
        NetworkExceptions.getDioException(error);
      });
    } catch (e) {
      debugPrint("Search Error: $e");
    } finally {
      isLoading = false.obs;
      update();
    }
  }



  // Delete recent search
  void deleteRecent(String query) {
    recentSearches.remove(query);
  }
}
