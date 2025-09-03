import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @singleton
  String get baseUrl =>
      'https://dev.inviteflare.com/'; // Your base URL here

  @singleton
  http.Client get httpClient => http.Client();
}
