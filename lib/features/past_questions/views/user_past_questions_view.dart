import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/images.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/empty_list.dart';
import '../providers/user_past_questions_provider.dart';
import 'past_question_pdf_view.dart';

class UserPastQuestionsView extends ConsumerWidget {
  const UserPastQuestionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final courses = watch(userPastQuestionsProvider);
    return Scaffold(
      appBar: CustomAppBar(title: 'Past Questions'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: courses.when(
                data: (data) => data.isEmpty
                    ? EmptyList(text: 'No past question to display')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PastQuestionPDFView(
                                question: data[index],
                                showEdit: false,
                              ),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(AppImages.questionIcon),
                            title: Text(
                              data[index].courseTitle,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            subtitle: Text(data[index].year),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      ),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => ErrorList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
