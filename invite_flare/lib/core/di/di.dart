import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencyInjection(String env) => getIt.init(environment: env);
