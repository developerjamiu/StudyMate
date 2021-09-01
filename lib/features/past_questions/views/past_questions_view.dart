import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/images.dart';
import '../../../shared/widgets/empty_list.dart';
import '../providers/past_questions_provider.dart';
import 'past_question_pdf_view.dart';

class PastQuestionsView extends ConsumerWidget {
  const PastQuestionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final pastQuestions = watch(pastQuestionsProvider);
    return Expanded(
      child: pastQuestions.when(
        data: (data) => data.isEmpty
            ? EmptyList(text: 'You have not created any past question')
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PastQuestionPDFView(
                        question: data[index],
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
    );
  }
}
