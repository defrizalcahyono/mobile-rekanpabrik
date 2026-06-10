import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = jsonResponse['token'];

        await _saveToken(token);

        return {
          'status': true,
          'token': token,
        };
      }

      return {
        'status': false,
        'message': jsonResponse['message'] ?? 'Login gagal',
      };
    } catch (e) {
      return {
        'status': false,
        'message': e.toString(),
      };
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'auth_token',
      token,
    );
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('auth_token');
  }

  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('auth_token');

      return true;
    } catch (e) {
      return false;
    }
  }
}