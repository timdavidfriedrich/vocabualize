import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/report/send_report_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/common/domain/entities/report.dart';
import 'package:vocabualize/src/features/reports/domain/entities/report_type.dart';

class ReportArguments {
  final ReportType reportType;
  Vocabulary vocabulary = Vocabulary();
  ReportArguments({required this.reportType});
  ReportArguments.bug() : reportType = ReportType.bug;
  ReportArguments.translation({required this.vocabulary})
      : reportType = ReportType.translation;
}

class ReportScreen extends ConsumerStatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/Report";

  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  late ReportArguments? arguments;
  late ReportType reportType = ReportType.none;
  Vocabulary? vocabulary;

  String text = "";
  bool textIsValid = true;

  int maxLines = 8;
  int maxLength = 240;
  final int _maxLinesTranslation = 5;
  final int _maxLengthTranslation = 128;

  void _updateText(String text) {
    this.text = text;
  }

  void _checkIfTextIsValid() {
    setState(() {
      textIsValid = text.length <= maxLength;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        arguments =
            (ModalRoute.of(context)?.settings.arguments as ReportArguments?);
        arguments?.let((args) {
          reportType = args.reportType;
          if (reportType == ReportType.translation) {
            vocabulary = args.vocabulary;
            maxLines = _maxLinesTranslation;
            maxLength = _maxLengthTranslation;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sendReport = ref.watch(sendReportUseCaseProvider);

    void submit() {
      Report report;
      if (reportType == ReportType.translation) {
        report = TranslationReport(
          source: vocabulary?.source ?? "",
          target: vocabulary?.target ?? "",
          sourceLanguageId: vocabulary?.sourceLanguageId ?? "",
          targetLanguageId: vocabulary?.targetLanguageId ?? "",
          description: text,
        );
      } else {
        report = BugReport(description: text);
      }
      sendReport(report);
      context.pop();
    }

    final isTranslation = reportType == ReportType.translation;

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.largeBorderRadius),
          topRight: Radius.circular(Dimensions.largeBorderRadius),
        ),
        child: Scaffold(
          appBar: AppBar(
            // TODO: Replace with arb
            title: Text(isTranslation ? "Faulty translation" : "Report bug"),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.largeSpacing,
            ),
            children: [
              const SizedBox(height: Dimensions.mediumSpacing),
              if (isTranslation) ...[
                _SourceTargetRow(vocabulary: vocabulary),
                const SizedBox(height: Dimensions.largeSpacing),
              ],
              TextField(
                maxLines: maxLines,
                maxLength: maxLength,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                onChanged: (text) {
                  _updateText(text);
                  _checkIfTextIsValid();
                },
                decoration: InputDecoration(
                  label: Text(
                    // TODO: Replace with arb
                    isTranslation ? "Note (optional)" : "Description",
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.mediumSpacing),
              ElevatedButton(
                onPressed: submit.takeIf((_) {
                  return textIsValid && (isTranslation || text.isNotEmpty);
                }),
                // onPressed: null,
                // TODO: Replace with arb
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceTargetRow extends StatelessWidget {
  final Vocabulary? vocabulary;
  const _SourceTargetRow({required this.vocabulary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(vocabulary?.source ?? "")),
        const SizedBox(width: Dimensions.smallSpacing),
        const Icon(Icons.arrow_forward_rounded),
        const SizedBox(width: Dimensions.smallSpacing),
        Flexible(
          child: Text(
            vocabulary?.target ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
