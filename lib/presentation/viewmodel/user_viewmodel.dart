import 'package:flutter/widgets.dart';
import 'package:projeto_flutter/data/repository/user_repository.dart';

class UserViewmodel with ChangeNotifier {
  final UserRepository _userRepository;

  String? _token;
  String? _username;
  String? _erroMessage;
  bool _isLoading = false;

  UserViewmodel(this._userRepository);

  String? get token => _token;
  String? get username => _username;
  String? get errorMesage => _erroMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      notifyListeners();
      return false;
    }
    _isLoading = true;
    _erroMessage = null;
    notifyListeners();

    try {
      _token = await _userRepository.login(username, passaword);
      _username = username;
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _token = null;
      _username = null;
      _erroMessage = e.toString();
    }
  }

  void logout() {
    _token = null;
    _username = null;
    _erroMessage = null;
    notifyListeners();
  }

  void clearErroMessage() {
    _erroMessage = null;
    notifyListeners();
  }
}
