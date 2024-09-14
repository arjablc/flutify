import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/auth_viewmodel.dart';
import '../../../../core/widgets/circular_loader.dart';
import '../../repository/auth_token_repo.dart';
import '../../../../core/utils/snack_bar_util.dart';
import '../../../../core/failure/failure.dart';

class AboutMePage extends ConsumerWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    ref.listen(
      authViewModelProvider,
      (previous, next) {
        if (next?.hasError ?? false) {
          showErrorSnackbar(failure: next?.error as ServerFailure, context: context);
        }
      },
    );
    final state = ref.watch(authViewModelProvider);
    debugPrint(state.toString());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Center(
            child: isLoading
                ? const CustomLoader()
                : Column(
                    children: [
                      state?.hasValue == true
                          ? Text(state!.value.toString(),
                              style: Theme.of(context).textTheme.titleSmall)
                          : Text('No user data', style: Theme.of(context).textTheme.titleLarge),
                      TextButton(
                          onPressed: () {
                            ref.read(authTokenRepoProvider).invalidateToken();
                          },
                          child: const Text('Delete accessToken'))
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(authViewModelProvider.notifier).getCurrentUser,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
