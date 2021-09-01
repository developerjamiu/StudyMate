import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_user.dart';
import 'user_repository_provider.dart';

final appUserProvider = StreamProvider<AppUser>((ref) {
  return ref.watch(userRepositoryProvider).getUser();
});

final appUserFutureProvider = FutureProvider<AppUser>((ref) {
  return ref.watch(userRepositoryProvider).getUserFuture();
});
