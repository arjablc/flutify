import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/models/user_model.dart';

part 'auth_state_service.g.dart';

@Riverpod(keepAlive: true)
class AuthStateService extends _$AuthStateService {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user) {
    state = user;
  }
}
