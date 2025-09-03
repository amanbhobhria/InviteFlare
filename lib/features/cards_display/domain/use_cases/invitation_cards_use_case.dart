import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/features/category/data/data.dart';
import 'package:invite_flare/shared/domain/entities/invitation_card_entity.dart';

@injectable
class InvitationCardsUseCase extends UseCase<List<Data>, NoParams> {
  final CategoryRepository _categoryRepository =
      CategoryRepository(apiHandler: APIHandler());

  @override
  Future<List<Data>> call(NoParams params) async {
    final response =
        await _categoryRepository.getCardsByCategory(params.categoryName);

    final data = InvitationCardEntity.fromJson(jsonDecode(response.body));
    return data.data!;
  }
}
