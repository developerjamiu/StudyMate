import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/app_theme.dart';
import 'core/constants/colors.dart';
import 'core/constants/strings.dart';
import 'features/authentication/views/authentication_wrapper.dart';
import 'features/study_plans/models/study_plans.dart';
import 'features/study_plans/providers/study_plan_repository_provider.dart';
import 'features/study_plans/views/edit_study_plan_view.dart';
import 'services/navigation_service.dart';
import 'services/scaffold_messenger_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: AppStrings.basicChannel,
        channelName: 'Basic notifications',
        defaultColor: AppColors.primaryColor,
        importance: NotificationImportance.High,
        ledColor: AppColors.backgroundColor,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: AppStrings.scheduledChannel,
        channelName: 'Scheduled notifications',
        defaultColor: AppColors.primaryColor,
        importance: NotificationImportance.High,
        ledColor: AppColors.backgroundColor,
        channelShowBadge: true,
        locked: true,
      ),
    ],
  );

  await Firebase.initializeApp();
  runApp(ProviderScope(child: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('The PA will like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then(
                        (_) => Navigator.of(context),
                      ),
                  child: Text('Allow'),
                ),
              ],
            ),
          );
        }
      },
    );

    AwesomeNotifications().actionStream.listen((notification) async {
      String id = notification.payload!['id']!;
      StudyPlan studyPlan =
          await context.read(studyPlanRepositoryProvider).getStudyPlan(id);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => EditStudyPlanView(studyPlan),
          ),
          (route) => route.isFirst);
    });
    super.initState();
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      scaffoldMessengerKey:
          context.read(scaffoldMessengerServiceProvider).scaffoldMessengerKey,
      navigatorKey: context.read(navigationServiceProvider).navigatorKey,
      home: AuthenticationWrapper(),
    );
  }
}
