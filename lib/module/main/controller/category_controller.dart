import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/module/main/widget/use_cases/categories_use_case.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';
import 'package:invite_flare/core/base/base.dart';

@injectable
class CategoriesController extends GetxController {
  final CategoriesUseCase categoriesUseCase;

  CategoriesController(this.categoriesUseCase);

  var isLoading = false.obs;
  var categories = <CategoryEntity>[].obs;

  void fetchCategories(String categoryName) async {
    isLoading.value = true;

    final result = await categoriesUseCase(NoParams(categoryName: categoryName));
    categories.value = result;

    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchCategories('LOL'); // You can pass the category dynamically too
    super.onInit();
  }
}
