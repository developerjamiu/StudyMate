import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldMessengerService {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
  }
}

final scaffoldMessengerServiceProvider = Provider(
  (ref) => ScaffoldMessengerService(),
);
