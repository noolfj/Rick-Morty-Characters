import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://rickandmortyapi.com/api";

  Future<dynamic> _get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Ошибка при запросе к $endpoint: ${response.statusCode}");
    }
  }

  Future<dynamic> getCharacters({int page = 1}) async {
    return await _get("character?page=$page");
  }
}
