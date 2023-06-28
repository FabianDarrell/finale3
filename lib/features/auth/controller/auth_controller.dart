import 'package:finale3/core/utils.dart';
import 'package:finale3/features/auth/view/login_view.dart';
import 'package:finale3/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finale3/apis/auth_api.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

class AuthController extends StateNotifier <bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI}): _authAPI=authAPI, super(false);
  
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email, 
      password: password, 
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message), 
      (r) {
        showSnackBar(context, 'Account created! Please login.');
        Navigator.push(context, LoginView.route());
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email, 
      password: password, 
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message), 
      (r) => {
        Navigator.push(context, HomeView.route())
      },
    );
  }
}