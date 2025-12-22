import 'package:flutter/material.dart';
import 'package:restaurant_critic/models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'email': 'user@example.com',
      'name': 'Иван Иванов',
      'password': 'password123',
      'createdAt': DateTime.now().subtract(const Duration(days: 30)),
    },
  ];

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      final user = _mockUsers.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => throw Exception('Пользователь не найден'),
      );

      _currentUser = User(
        id: user['id'] as String,
        email: user['email'] as String,
        name: user['name'] as String,
        createdAt: user['createdAt'] as DateTime,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }
}
