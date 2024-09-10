import 'package:flutify/core/failure/failure.dart';
import 'package:flutify/features/auth/repository/auth_token_repo.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutify/features/auth/models/user_model.dart';
import 'package:flutify/features/auth/repository/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepo;
  late AuthTokenRepo _tokenRepo;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRemoteRepositoryProvider);
    _tokenRepo = ref.watch(authTokenRepoProvider);
    return null;
  }

  Future<void> loginUser({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final result = await _authRemoteRepo.loginUser(email: email, password: password);

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) {
        if (r.accessToken != null) {
          _tokenRepo.setToken(r.accessToken!);
        }
        state = AsyncValue.data(r);
      },
    );
  }

  Future<void> signupUser(
      {required String email, required String name, required String password}) async {
    state = const AsyncValue.loading();
    final result = await _authRemoteRepo.signupUser(email: email, password: password, name: name);

    result.fold(
        (l) => state = AsyncValue.error(l, StackTrace.current), (r) => state = AsyncValue.data(r));
  }

  Future<void> getMe() async {
    state = const AsyncValue.loading();
    final token = await _tokenRepo.getToken();
    if (token == null) {
      state = AsyncValue.error(const ServerFailure(message: 'Expired session'), StackTrace.current);
      return;
    }
    final result = await _authRemoteRepo.getMe(token);
    result.fold(
        (l) => state = AsyncValue.error(l, StackTrace.current), (r) => state = AsyncValue.data(r));
  }
}
