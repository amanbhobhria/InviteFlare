import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/mock/mock_data.dart';

import 'package:invite_flare/shared/shared.dart';

@Injectable()
class CategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  @override
  Future<List<CategoryEntity>> call(NoParams params) async =>
      MockData.categoriesNav
          .map((category) => CategoryEntity.fromJson(category))
          .toList();
}
