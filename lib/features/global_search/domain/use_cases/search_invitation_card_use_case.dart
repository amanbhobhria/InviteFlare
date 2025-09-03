import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/features/search/data/data.dart';
import 'package:invite_flare/shared/shared.dart';

@Injectable()
class SearchInvitationCardUseCase extends UseCase<List<Data>, String> {
  final SearchRepository _searchRepository =
      SearchRepository(apiHandler: APIHandler());

  @override
  Future<List<Data>> call(String params) async {
    final response = await _searchRepository.search(params);
    InvitationCardEntity invitationCardEntity =
        InvitationCardEntity.fromJson(jsonDecode(response.body));
    return invitationCardEntity.data!;
  }
}
