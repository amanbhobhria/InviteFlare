import 'package:injectable/injectable.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/module/main/model/category_data_response_model.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

@injectable
class CategoriesController extends GetxController {
  var isCategoryLoading = false.obs;
  var isLoading = false.obs;
    CategoryDataResponseModel categoryDataResponseModel =
      CategoryDataResponseModel();
  List<CategoriesData> cateroiesResponseModel = [];

  @override
  void onInit() {
    super.onInit();
  }



 Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      await DioClient(Dio())
          .get('v1/invitations/nav-menu', skipAuth: false)
          .then(
        (value) {
          if (value != null) {
            categoryDataResponseModel =
                CategoryDataResponseModel.fromJson(value);
            cateroiesResponseModel.clear(); // old data hatane ke liye
            cateroiesResponseModel
                .addAll(categoryDataResponseModel.categories ?? []);

            print(
                'Cateriiiiiiiiiiiiiiii--------------${cateroiesResponseModel.length}');
            update();
          }
        },
      ).onError(
        (error, stackTrace) {
          print('Error---$error');
          print('Error---$stackTrace');
          NetworkExceptions.getDioException(error);
        },
      );
    } finally {
      isCategoryLoading.value = false;
    }
  }
  @override
  void onReady() {
    fetchCategories();
    super.onReady();
  }
}