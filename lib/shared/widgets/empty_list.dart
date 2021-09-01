import 'package:flutter/material.dart';

import '../../core/constants/images.dart';
import 'spacing.dart';
import 'widgets.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        children: [
          Spacer(),
          Image.asset(AppImages.noItem),
          Text(
            text,
            style: theme.textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        children: [
          Expanded(child: Image.asset(AppImages.error)),
          Text(
            'Something went wrong!',
            style: theme.textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          Spacing.tinyHeight(),
          Text(
            'Can\t load items right now',
            style: theme.textTheme.subtitle1,
          ),
          Spacing.largeHeight(),
        ],
      ),
    );
  }
}
