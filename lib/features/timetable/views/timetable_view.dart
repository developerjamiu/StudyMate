// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:ionicons/ionicons.dart';

// import '../../../shared/enums/priority.dart';
// import '../../../shared/widgets/custom_app_bar.dart';
// import '../../../shared/widgets/spacing.dart';
// import '../../../shared/widgets/widgets.dart';
// import '../../study_plans/controllers/study_plans_controller.dart';
// import '../../study_plans/models/study_plans.dart';
// import '../../study_plans/providers/completed_study_plans_provider.dart';
// import '../../study_plans/providers/pending_study_plans_provider.dart';

// class TimetableView extends HookWidget {
//   const TimetableView({
//     Key? key,
//   }) : super(key: key);

//   String getDayByIndex(int index) {
//     if (index == 0)
//       return 'Monday';
//     else if (index == 1)
//       return 'Tuesday';
//     else if (index == 2)
//       return 'Wednesday';
//     else if (index == 3)
//       return 'Thursday';
//     else
//       return 'Friday';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     final selectedItem = useState(0);

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Timetable',
//         trailing: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {},
//           // onPressed: () => Navigator.of(context).push(
//           //     // MaterialPageRoute(
//           //     //   builder: (_) => CreateStudyPlanView(),
//           //     // ),
//           //     ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CupertinoSlidingSegmentedControl(
//               thumbColor: theme.colorScheme.secondary,
//               groupValue: selectedItem.value,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               children: {
//                 0: Container(
//                   height: 36,
//                   child: Center(child: Text('MON')),
//                 ),
//                 1: Container(
//                   height: 36,
//                   child: Center(child: Text('TUE')),
//                 ),
//                 2: Container(
//                   height: 36,
//                   child: Center(child: Text('WED')),
//                 ),
//                 3: Container(
//                   height: 36,
//                   child: Center(child: Text('THU')),
//                 ),
//                 4: Container(
//                   height: 36,
//                   child: Center(child: Text('FRI')),
//                 ),
//               },
//               onValueChanged: (int? value) => selectedItem.value = value!,
//             ),
//             Spacing.mediumHeight(),
//             Text(
//               getDayByIndex(selectedItem.value).toUpperCase(),
//               style: theme.textTheme.subtitle1,
//             ),
//             Spacing.mediumHeight(),
//             Consumer(
//               builder: (_, watch, __) {
//                 return TabView(
//                   currentIndex: selectedItem.value,
//                   items: [
//                     watch(pendingStudyPlansProvider),
//                     watch(completedStudyPlansProvider),
//                     watch(pendingStudyPlansProvider),
//                     watch(completedStudyPlansProvider),
//                     watch(completedStudyPlansProvider),
//                   ]
//                       .map(
//                         (stream) => Expanded(
//                           child: stream.when(
//                             data: (data) => data.isEmpty
//                                 ? EmptyList(
//                                     text:
//                                         'You dont\'t have any pending\nStudy Plans',
//                                   )
//                                 : ListView.builder(
//                                     physics: BouncingScrollPhysics(),
//                                     itemCount: data.length,
//                                     itemBuilder: (context, index) =>
//                                         StudyPlanListItem(
//                                       studyPlan: data[index],
//                                     ),
//                                   ),
//                             loading: () => Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                             error: (_, __) => ErrorList(),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TabView extends StatelessWidget {
//   final List<Widget> items;
//   final int currentIndex;

//   const TabView({
//     Key? key,
//     required this.currentIndex,
//     required this.items,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return items[currentIndex];
//   }
// }

// class StudyPlanListItem extends StatelessWidget {
//   final StudyPlan studyPlan;

//   const StudyPlanListItem({
//     Key? key,
//     required this.studyPlan,
//   }) : super(key: key);

//   Color getColorByPriority(Priority priority) {
//     if (priority == Priority.low)
//       return Colors.green;
//     else if (priority == Priority.normal)
//       return Colors.amber;
//     else
//       return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       // onTap: () => Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //     builder: (_) => EditStudyPlanView(studyPlan),
//       //   ),
//       // ),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: theme.colorScheme.onSurface,
//             width: 0.1,
//           ),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 2.0, left: 2.0),
//               child: CircleAvatar(
//                 backgroundColor: getColorByPriority(studyPlan.priority),
//                 radius: 4,
//               ),
//             ),
//             Spacing.smallWidth(),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Due Date ${DateFormat('dd-MM-yyyy HH:ma').format(studyPlan.date)}',
//                     style: theme.textTheme.caption,
//                   ),
//                   Spacing.tinyHeight(),
//                   Text(
//                     studyPlan.title,
//                     style: theme.textTheme.headline6?.copyWith(
//                       color: theme.colorScheme.onBackground,
//                     ),
//                   ),
//                   Spacing.tinyHeight(),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Priority ',
//                         style: theme.textTheme.caption,
//                       ),
//                       Text(
//                         studyPlan.priority.name.toUpperCase(),
//                         style: theme.textTheme.subtitle1?.copyWith(
//                           color: getColorByPriority(studyPlan.priority),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: studyPlan.completed == true
//                   ? Icon(
//                       Ionicons.checkmark_done_circle,
//                       color: theme.accentColor,
//                     )
//                   : Icon(Ionicons.checkmark_done_circle_outline),
//               onPressed: () => context
//                   .read(studyPlansControllerProvider)
//                   .toggleStudyPlanComplete(
//                     studyPlan.id,
//                     completed: studyPlan.completed,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
