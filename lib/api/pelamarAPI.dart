import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

class Pelamarapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> updateDataPelamar({
    required int idpelamar,
    required String firstname,
    required String lastname,
    required String email,
    required String aboutme,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      print("TOKEN NULL");
      return false;
    }

    final url = Uri.parse(
      '$apiUrl/pelamar/$idpelamar',
    );

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'aboutMe': aboutme,
      }),
    );

    print("===== UPDATE DATA PELAMAR =====");
    print("URL : $url");
    print("STATUS : ${response.statusCode}");
    print("BODY : ${response.body}");
    print("===============================");

    return response.statusCode == 200;
  }

  Future<bool> updateProfilePicture({
    required int idpelamar,
    required File imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      print("TOKEN NULL");
      return false;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        '$apiUrl/pelamar/$idpelamar/profile-picture',
      ),
    );

    request.headers['Authorization'] = 'Bearer $token';

    if (await imagePath.exists()) {
      final mimeType = lookupMimeType(imagePath.path);

      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_pict',
          imagePath.path,
          contentType: MediaType.parse(
            mimeType ?? 'image/jpeg',
          ),
        ),
      );
    } else {
      print("FILE TIDAK ADA");
      return false;
    }

    final response = await request.send();

    final body = await response.stream.bytesToString();

    print("===== UPDATE FOTO =====");
    print("URL : ${request.url}");
    print("STATUS : ${response.statusCode}");
    print("BODY : $body");
    print("=======================");

    return response.statusCode == 200;
  }

  Future<bool> updateCV({
    required int idpelamar,
    required File imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      print("TOKEN NULL");
      return false;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        '$apiUrl/pelamar/$idpelamar/cv',
      ),
    );

    request.headers['Authorization'] = 'Bearer $token';

    if (await imagePath.exists()) {
      final mimeType = lookupMimeType(imagePath.path);

      request.files.add(
        await http.MultipartFile.fromPath(
          'CV',
          imagePath.path,
          contentType: MediaType.parse(
            mimeType ?? 'application/pdf',
          ),
        ),
      );
    } else {
      print("FILE CV TIDAK ADA");
      return false;
    }

    final response = await request.send();

    final body = await response.stream.bytesToString();

    print("===== UPDATE CV =====");
    print("URL : ${request.url}");
    print("STATUS : ${response.statusCode}");
    print("BODY : $body");
    print("=====================");

    return response.statusCode == 200;
  }

  Future<bool> changePassword({
    required int idpelamar,
    required String newPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('auth_token');

    if (token == null) {
      print("TOKEN NULL");
      return false;
    }

    final url = Uri.parse(
      '$apiUrl/pelamar/$idpelamar/password',
    );

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'newPass': newPassword,
      }),
    );

    print("===== CHANGE PASSWORD =====");
    print("URL : $url");
    print("STATUS : ${response.statusCode}");
    print("BODY : ${response.body}");
    print("===========================");

    return response.statusCode == 200;
  }

  Future<bool> createAccount(
      String Fname, String Lname, String email, String password) async {
    var url = Uri.parse('$apiUrl/auth/register/pelamar');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': Fname,
          'last_name': Lname
        }));

    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
