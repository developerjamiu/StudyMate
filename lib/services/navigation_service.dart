import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<T?>? to<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState?.push(route);
  }

  Future<T?>? toNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?>? off<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) {
    return navigatorKey.currentState?.pushReplacement(
      newRoute,
      result: result,
    );
  }

  Future<T?>? offNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?>? offAll<T extends Object?>(
    Route<T> newRoute,
    bool Function(Route<dynamic>) predicate,
  ) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      newRoute,
      predicate,
    );
  }

  Future<T?>? offAllNamed<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void back<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}

final navigationServiceProvider = Provider(
  (ref) => NavigationService(),
);
