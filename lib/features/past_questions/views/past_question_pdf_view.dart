import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/edit_past_question_controller.dart';
import '../models/past_question.dart';
import '../providers/past_questions_repository_provider.dart';
import 'edit_past_question_view.dart';

class PastQuestionPDFView extends StatefulWidget {
  final PastQuestion question;
  final bool showEdit;

  const PastQuestionPDFView({
    Key? key,
    required this.question,
    this.showEdit = true,
  }) : super(key: key);

  @override
  _PastQuestionPDFViewState createState() => _PastQuestionPDFViewState();
}

class _PastQuestionPDFViewState extends State<PastQuestionPDFView> {
  File? pdf;

  @override
  void initState() {
    loadPDF();
    super.initState();
  }

  void loadPDF() async {
    pdf = await context
        .read(pastQuestionRepositoryProvider)
        .getQuestionFile(widget.question.fileDownloadUrl);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Statusbar(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.question.courseTitle,
        ),
        body: Column(
          children: [
            Expanded(
              child: pdf == null
                  ? Center(child: CircularProgressIndicator())
                  : PDFView(
                      fitEachPage: true,
                      filePath: pdf?.path,
                    ),
            ),
            widget.showEdit
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            label: 'Edit',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditPastQuestionView(
                                    widget.question,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Spacing.mediumWidth(),
                        Expanded(
                          child: AppElevatedButton(
                            label: 'Delete',
                            onPressed: () {
                              context
                                  .read(editPastQuestionControllerProvider)
                                  .deletePastQuestion(
                                    widget.question.id,
                                    url: widget.question.fileDownloadUrl,
                                  );

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : ListTile(
                    title: Text(widget.question.department.name),
                    subtitle: Text(widget.question.level.name),
                    trailing: Text(widget.question.year),
                  ),
          ],
        ),
      ),
    );
  }
}
