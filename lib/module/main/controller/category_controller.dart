import 'package:injectable/injectable.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

@injectable
class CategoriesController extends GetxController {
  List<CateroiesResponseModel> cateroiesResponseModel = [];
  var isCategoryLoading = false.obs;
  var isLoading = false.obs;
  var categories = <CategoryEntity>[
    CategoryEntity.fromJson({
      'title': 'Birthday',
      'slug': 'birthday',
      'bg_color': '#F2F2FF',
      'icon_xs':
      'https://paperpost-ce6b5.web.app/assets/images/home-category/birthday.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Wedding',
      'slug': 'wedding',
      'bg_color': '#FFF6F7',
      'icon_xs':
      'https://paperpost-ce6b5.web.app/assets/images/home-category/wedding.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Baby Shower',
      'slug': 'baby-shower',
      'bg_color': '#F1F7FF',
      'icon_xs':
      'https://paperpost-ce6b5.web.app/assets/images/home-category/baby-shower.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Graduation',
      'slug': 'graduation',
      'bg_color': '#ECFFF7',
      'icon_xs':
      'https://paperpost-ce6b5.web.app/assets/images/home-category/graduation.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'New Year',
      'slug': 'new-year',
      'bg_color': '#FFF9F0',
      'icon_xs':
      'https://paperpost-ce6b5.web.app/assets/images/home-category/new-year.svg',
    }),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }



  Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      await DioClient(Dio())
          .get('v1/invitations/mob/categories', skipAuth: false)
          .then(
            (value) {
          if (value != null) {
            if (value is List) {
              cateroiesResponseModel.clear(); // old data hatane ke liye
              cateroiesResponseModel.addAll(
                value.map((e) => CateroiesResponseModel.fromJson(e)).toList(),
              );
            }
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