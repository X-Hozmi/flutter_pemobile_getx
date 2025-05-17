import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/domain/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String stringEmail = '';
  String stringPassword = '';

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;

  final AuthRepository authRepository;
  final GoRouter router;

  AuthController({required this.authRepository, required this.router});

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Email/phone and password are required';
        return;
      }

      final result = await authRepository.login(email, password);

      await result.fold(
        (failure) async {
          errorMessage.value = 'Invalid credentials';
        },
        (success) async {
          isLoggedIn.value = true;
          stringEmail = emailController.text.trim();
          stringPassword = passwordController.text;
          router.goNamed('home');
        },
      );
    } catch (e) {
      errorMessage.value = 'Login failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      log('Method logout called');
      isLoading.value = true;

      final result = await authRepository.logout();

      await result.fold(
        (failure) async {
          errorMessage.value = 'Failed to Logout: ${failure.message}';
          log(errorMessage.value);
        },
        (success) async {
          isLoggedIn.value = false;
          emailController.clear();
          passwordController.clear();
          router.goNamed('login');
        },
      );
    } catch (e) {
      errorMessage.value = 'Logout failed: ${e.toString()}';
      log(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
