import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class ApiService {
  static Future<List<Country>> fetchCountries() async {
    final url = Uri.parse('https://countriesnow.space/api/v0.1/countries');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List countries = json.decode(response.body)['data'];
      return countries.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
