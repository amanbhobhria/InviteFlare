import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart'
    show DioClient;
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';

class SearchPageController extends GetxController {
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

  // Perform search
  /// Call Search API
  void callSearchApi(String query) async {
    try {
      isLoading.value = true;

      DioClient dioClient = DioClient(Dio());
      await dioClient.get(
        'api/v1/search',
        queryParameters: {'q': query},
      ).then((value) {
        if (value != null) {
          isLoading.value = false;

          // ✅ update results
          searchResults.value = value['data'] ?? [];

          // ✅ save in recent searches
          if (query.isNotEmpty && !recentSearches.contains(query)) {
            recentSearches.insert(0, query);
          }

          debugPrint("✅ Search success: $value");
        }
      }).onError(
        (error, stackTrace) {
          isLoading.value = false;
          Get.snackbar(
              "Search Failed", NetworkExceptions.getDioException(error));
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  // Delete recent search
  void deleteRecent(String query) {
    recentSearches.remove(query);
  }
}
