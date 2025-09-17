import 'package:get/get.dart';
import 'package:invite_flare/core/base/usecase.dart';
import 'package:invite_flare/module/main/widget/use_cases/categories_use_case.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

class HomeController extends GetxController {
  // final ExplainerUseCase explainerUseCase;
  // final ExpandableCardUseCase expandableCardUseCase;



  // Category
  var isCategoryLoading = false.obs;
  var categories = <CategoryEntity>[].obs;

  // Explainer Section
  var isExplainerLoading = false.obs;
  var explainerData = <String, dynamic>{}.obs;

  // Expandable Cards
  var isExpandableLoading = false.obs;
  var expandableCardData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    // fetchCategories();
    // fetchExplainerSection();
    // fetchExpandableCards();
  }

  // Future<void> fetchCategories() async {
  //   try {
  //     isCategoryLoading.value = true;
  //     final result = await categoriesUseCase(NoParams(categoryName: ''));
  //     categories.assignAll(result);
  //   } finally {
  //     isCategoryLoading.value = false;
  //   }
  // }

  // Future<void> fetchExplainerSection() async {
  //   try {
  //     isExplainerLoading.value = true;
  //     final result = await explainerUseCase();
  //     explainerData.assignAll(result);
  //   } finally {
  //     isExplainerLoading.value = false;
  //   }
  // }

  // Future<void> fetchExpandableCards() async {
  //   try {
  //     isExpandableLoading.value = true;
  //     final result = await expandableCardUseCase();
  //     expandableCardData.assignAll(result);
  //   } finally {
  //     isExpandableLoading.value = false;
  //   }
  // }
}
