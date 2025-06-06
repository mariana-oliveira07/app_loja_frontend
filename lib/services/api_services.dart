import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_flutter/data/models/produto_model.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<Map<String, dynamic>> getProdutos({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/produtos/?page=$page'));

    if (response.statusCode == 200) {
      String decodedBody = utf8.decode(
        response.bodyBytes,
      ); // Garante a decodificação correta
      Map<String, dynamic> data = json.decode(decodedBody);

      List<Produto> produtos =
          (data['results'] as List)
              .map((json) => Produto.fromJson(json))
              .toList();

      return {
        'produtos': produtos,
        'count': data['count'],
        'nextPage': data['next'], // URL da próxima página
        'previousPage':
            data['previous'], // Corrigido: 'previous' em vez de 'previus'
      };
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/token/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password, // Corrigido: 'password' em vez de 'passaword'
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String token = data["access"]; // Corrigido: 'access' em vez de 'acess'
      return token;
    } else {
      throw Exception("Falha ao fazer login");
    }
  }
}
