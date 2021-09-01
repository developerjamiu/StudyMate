import 'package:awesome_notifications/awesome_notifications.dart';

import '../core/constants/strings.dart';
import '../features/study_plans/models/study_plans.dart';

class NotificationService {
  static Future<void> createStudyPlanNotification({
    required StudyPlan studyPlan,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        payload: {'id': studyPlan.id},
        id: studyPlan.timestamp.millisecondsSinceEpoch.remainder(100000),
        channelKey: AppStrings.scheduledChannel,
        title: Emojis.paper_books + studyPlan.title,
        body: studyPlan.note ?? 'No note',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'COMPLETE', label: 'Complete'),
      ],
      schedule: NotificationCalendar.fromDate(date: studyPlan.date),
    );
  }

  static Future<void> cancelStudyPlanNotification({
    required StudyPlan studyPlan,
  }) async {
    await AwesomeNotifications().cancel(
      studyPlan.timestamp.millisecondsSinceEpoch.remainder(100000),
    );
  }
}
