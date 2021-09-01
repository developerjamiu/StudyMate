import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';

enum StatusbarType { normal, primary }

class Statusbar extends StatelessWidget {
  final Widget child;
  final StatusbarType statusbarType;

  const Statusbar({
    Key? key,
    required this.child,
    this.statusbarType = StatusbarType.normal,
  }) : super(key: key);

  const Statusbar.primary({
    Key? key,
    required this.child,
    this.statusbarType = StatusbarType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: statusbarType == StatusbarType.primary
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: AppColors.noColor,
        systemNavigationBarColor: statusbarType == StatusbarType.primary
            ? colorScheme.primary
            : colorScheme.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: child,
    );
  }
}
