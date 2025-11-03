// lib/providers/auth_provider.dart
// Versão simplificada para build no Windows sem Firebase
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Métodos stub - retornam falso e mensagem informativa
  Future<bool> loginWithEmail(String email, String password) async {
    _errorMessage = 'Autenticação desabilitada temporariamente';
    notifyListeners();
    return false;
  }

  Future<bool> signUpWithEmail(String email, String password, String name) async {
    _errorMessage = 'Autenticação desabilitada temporariamente';
    notifyListeners();
    return false;
  }

  Future<bool> signInWithGoogle() async {
    _errorMessage = 'Login com Google desabilitado temporariamente';
    notifyListeners();
    return false;
  }

  Future<bool> signInWithFacebook() async {
    _errorMessage = 'Login com Facebook não disponível no momento';
    notifyListeners();
    return false;
  }

  Future<bool> resetPassword(String email) async {
    _errorMessage = 'Recuperação de senha desabilitada temporariamente';
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    // No-op
  }
}