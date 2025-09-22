import 'package:get/get.dart';
import 'package:dio/dio.dart';


import 'package:flutter/material.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/module/home_2/model/category_list_response_model.dart';



class CategoryController extends GetxController {
  final searchController = TextEditingController();
  CategoryListResponseModel? categoryListResponseModel;
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
