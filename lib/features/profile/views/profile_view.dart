import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/authentication_repository.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/spacing.dart';
import '../../authentication/models/app_user.dart';
import 'update_email_view.dart';
import 'update_password_view.dart';
import 'update_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        backgroundColor: colorScheme.background.withOpacity(0.2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacing.height(72),
              CircleAvatar(
                backgroundColor: colorScheme.primary,
                radius: 36,
                child: Text(
                  user.fullName[0],
                  style: textTheme.headline6?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Spacing.bigHeight(),
              Text(
                user.fullName,
                style: textTheme.headline6,
              ),
              Spacing.tinyHeight(),
              Text(user.emailAddress),
              Spacing.mediumHeight(),
              ElevatedButton(
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  primary: colorScheme.secondary,
                  minimumSize: Size(140, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => UpdateProfileView(user),
                ),
              ),
              Spacing.bigHeight(),
              Divider(),
              Spacing.bigHeight(),
              ListTile(
                title: Text('Change Password', style: textTheme.bodyText1),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => UpdatePasswordView(),
                ),
              ),
              Spacing.bigHeight(),
              ListTile(
                title: Text('Change Email', style: textTheme.bodyText1),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => UpdateEmailView(),
                ),
              ),
              Spacing.bigHeight(),
              ListTile(
                title: Text('About', style: textTheme.bodyText1),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Spacing.bigHeight(),
              ElevatedButton(
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  primary: colorScheme.secondary,
                  minimumSize: Size(140, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed:
                    context.read(authenticationRepositoryProvider).logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
