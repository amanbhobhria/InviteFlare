import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/module/main/widget/use_cases/categories_use_case.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

@injectable
class CategoriesController extends GetxController {


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
  ].obs; // <-- RxList<CategoryEntity>

  @override
  void onInit() {
    super.onInit();
  }
}
