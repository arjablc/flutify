import 'package:flutify/features/auth/models/user_model.dart';
import 'package:flutify/features/auth/repository/auth_remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepo;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    state = const AsyncValue.loading();
    final result =
        await _authRemoteRepo.loginUser(email: email, password: password);
    result.fold((l) => state = AsyncValue.error(l, StackTrace.current), (r) {
      debugPrint(r.name);
      debugPrint(r.toString());
      state = AsyncValue.data(r);
    });
  }

  Future<void> signupUser(
      {required String email,
      required String name,
      required String password}) async {
    state = const AsyncValue.loading();
    final result = await _authRemoteRepo.signupUser(
        email: email, password: password, name: name);

    result.fold((l) => state = AsyncValue.error(l, StackTrace.current),
        (r) => AsyncValue.data(r));
  }
}
