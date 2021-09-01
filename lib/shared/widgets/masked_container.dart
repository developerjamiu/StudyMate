import 'package:flutter/material.dart';

import '../../core/constants/images.dart';

class MaskedContainer extends StatelessWidget {
  const MaskedContainer({
    Key? key,
    this.color,
    this.height = 186,
    required this.texts,
    this.onTap,
  })  : assert(texts.length == 2),
        super(key: key);

  final Color? color;
  final double height;
  final List<String> texts;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height,
            color: color,
            child: Image.asset(
              AppImages.mask,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 8,
            child: Text.rich(
              TextSpan(
                text: (texts[0] + '\n'),
                style: theme.textTheme.caption?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                children: [
                  TextSpan(
                    text: texts[1],
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
