import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:recipe_app_mvvm_riverpod/core/config/app_config.dart';

class ApiService {
  static Future<String?> getMethod({required String endpoint}) async {
    final url = Uri.parse(AppConfig.baseUrl + endpoint);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log("API SERVICE");
        log("Error fetching data");
        return null;
      }
    } catch (e) {
      log("API SERVICE");
      log(e.toString());
    }
  }
}
