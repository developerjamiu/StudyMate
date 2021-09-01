import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/widgets/empty_list.dart';
import '../../../shared/widgets/spacing.dart';
import '../providers/courses_provider.dart';
import 'edit_course_view.dart';

class CoursesView extends ConsumerWidget {
  const CoursesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final courses = watch(coursesProvider);
    return Expanded(
      child: courses.when(
        data: (data) => data.isEmpty
            ? EmptyList(text: 'You have not created any course')
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EditCourseView(data[index]),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 4),
                        Spacing.mediumWidth(),
                        Text(
                          data[index].title,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (_, __) => ErrorList(),
      ),
    );
  }
}
