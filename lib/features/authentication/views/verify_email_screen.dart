import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_mate/repositories/authentication_repository.dart';
import '../../../shared/widgets/spacing.dart';
import '../../../shared/widgets/status_bar.dart';
import '../../../shared/widgets/widgets.dart';
import 'authentication_wrapper.dart';

class VerifyEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Center(
              child: Card(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'The PA',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Spacing.mediumHeight(),
                      Icon(
                        Ionicons.mail_open_outline,
                        size: 36,
                        color: Theme.of(context).primaryColor,
                      ),
                      Spacing.bigHeight(),
                      Text(
                        'Verify your email',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Spacing.smallHeight(),
                      Center(
                        child: Text(
                            'A verification link has been sent to your email. Please confirm that you want to use this as your account email address. Once it\'s done I\'ll be able to start assisting you.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      SizedBox(height: 24),
                      AppElevatedButton(
                        onPressed: () async {
                          await context
                              .read(authenticationRepositoryProvider)
                              .logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => AuthenticationWrapper(),
                            ),
                          );
                        },
                        label: 'Log In',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
