import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/usecase.dart';

@injectable
class EventDetailsUseCase extends UseCase<bool, NoParams> {
  @override
  Future<bool> call(NoParams params) async => true;
}
