import 'package:flutter/material.dart';

import '../../../shared/widgets/status_bar.dart';
import '../../../shared/widgets/widgets.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Statusbar.primary(
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomRight,
                child: Text(
                  'TPA',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    height: 0,
                  ),
                ),
              ),
              Spacing.mediumHeight(),
              Text(
                'The PA',
                style: textTheme.headline6?.copyWith(
                  color: colorScheme.background,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
