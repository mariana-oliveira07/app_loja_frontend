import 'package:projeto_flutter/services/api_services.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<String> login(String username, String passaword) async {
    try {
      return await apiService.login(username, password);
    } catch (e) {
      throw Exception("Erro ap tentar realizar o login: $e");
    }
  }
}
 //sem user