import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._();

  static String baseUrl = dotenv.env['API_URL']!;
}
