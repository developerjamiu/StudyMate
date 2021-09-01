import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import 'spacing.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final Color? backgroundColor;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.trailing,
    this.title,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parentRoute = ModalRoute.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        leading: leading ??
            (parentRoute!.canPop
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: Navigator.of(context).pop,
                  )
                : null),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.noColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(
          title ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: backgroundColor ?? AppColors.noColor,
        elevation: 0,
        actions: [trailing ?? Spacing.empty()],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
