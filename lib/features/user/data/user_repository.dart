import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  UserRepository({required this.dio, required this.preferences});

  final Dio dio;
  final SharedPreferences preferences;

  static const _accessTokenKey = 'access_token';

  Future<void> register(String username, String email, String password) async {
    await dio
        .post('/auth/v1/signup', data: {'email': email, 'password': password});
  }

  Future<void> login(String email, String password) async {
    final response = await dio.post('/auth/v1/token?grant_type=password',
        data: {'email': email, 'password': password});
    final data = response.data as Map<String, dynamic>;
    await _setAccessToken(data['access_token']);
  }

  Future<void> forgotPassword(String email) async {
    await dio.post('/auth/v1/recover', data: {'email': email});
  }

  Future<void> _setAccessToken(String token) async {
    await preferences.setString(_accessTokenKey, token);
  }
}
