import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

final storage = FlutterSecureStorage();

void save(key, value) async {
  await storage.write(key: key, value: value);
}

void delete(key) async {
  return await storage.delete(key: key);
}

void login(token) {
  save('accessToken', token.accessToken);
  save('refreshToken', token.refreshToken);
  save('login', 'login');
}

void logout() async {
  await storage.deleteAll();
}

Future<String?> getAccessToken() async {
  return await storage.read(key: "accessToken");
}

Future<String?> getIsLogin() async {
  return await storage.read(key: 'login');
}