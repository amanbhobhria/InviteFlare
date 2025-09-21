import 'package:get/get.dart';
import 'package:dio/dio.dart';


import 'package:flutter/material.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/module/home_2/model/search_category_response_model.dart';


class SearchCategoryController extends GetxController {
  final searchController = TextEditingController();
  SearchCategoryResponseModel? searchResponse;

  bool isLoading = false;

  Future<void> searchCategory(String query) async {
    if (query.isEmpty) return;

    try {
      isLoading = true;
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
      isLoading = false;
      update();
    }
  }
}







// class SearchCategoryController extends GetxController {
//   final Dio _dio = Dio(BaseOptions(baseUrl: "{{url}}api/v1/"));
//
//   var isLoading = false.obs;
//   var searchResults = [].obs;
//   var error = "".obs;
//
//   Future<void> searchItems(String query) async {
//     if (query.isEmpty) return;
//
//     try {
//       isLoading.value = true;
//       error.value = "";
//
//       final response = await _dio.get("search", queryParameters: {"q": query});
//
//       if (response.statusCode == 200) {
//         searchResults.value = response.data["results"] ?? []; // assuming API response
//       } else {
//         error.value = "Something went wrong";
//       }
//     } catch (e) {
//       error.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
