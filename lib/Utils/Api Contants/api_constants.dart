// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String start = '${dotenv.env['API_URL']}';
    static String login_post =
      '$start/login/ThirdpartyLogin/index'; //Post Login User
 
}
