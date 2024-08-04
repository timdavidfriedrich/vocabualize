import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/reports/models/bug_report.dart';
import 'package:vocabualize/src/features/reports/models/report.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';
import 'package:vocabualize/src/features/reports/utils/report_type.dart';
import 'package:vocabualize/src/features/reports/models/translation_report.dart';

class ReportScreen extends StatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/Report";

  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late ReportArguments arguments;
  late ReportType reportType = ReportType.none;
  Vocabulary? vocabulary;

  String text = "";
  bool textIsValid = true;

  int maxLines = 8;
  int maxLength = 240;
  final int _maxLinesTranslation = 4;
  final int _maxLengthTranslation = 64;

  void _submit() {
    Report report;
    if (reportType == ReportType.translation) {
      report = TranslationReport(
        source: vocabulary!.source,
        target: vocabulary!.target,
        sourceLanguage: vocabulary!.sourceLanguage,
        targetLanguage: vocabulary!.targetLanguage,
        description: text,
      );
    } else {
      report = BugReport(description: text);
    }
    RemoteDatabaseDataSource.instance.sendReport(report);
    Navigator.pop(context);
  }

  void _updateText(String text) {
    this.text = text;
  }

  void _checkIfTextIsValid() {
    setState(() => textIsValid = text.length <= maxLength);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        arguments = (ModalRoute.of(context)!.settings.arguments as ReportArguments);
        reportType = arguments.reportType;
        if (reportType == ReportType.translation) {
          vocabulary = arguments.vocabulary;
          maxLines = _maxLinesTranslation;
          maxLength = _maxLengthTranslation;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
            // TODO: Replace with arb
            appBar: AppBar(title: Text(reportType == ReportType.translation ? "Faulty translation" : "Report bug")),
            body: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                reportType != ReportType.translation
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: Text(vocabulary!.source)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded),
                          const SizedBox(width: 8),
                          Flexible(child: Text(vocabulary!.target, style: TextStyle(color: Theme.of(context).colorScheme.error))),
                        ],
                      ),
                reportType != ReportType.translation ? Container() : const SizedBox(height: 32),
                TextField(
                  maxLines: maxLines,
                  maxLength: maxLength,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  onChanged: (text) {
                    _updateText(text);
                    _checkIfTextIsValid();
                  },
                  // TODO: Replace with arb
                  decoration: InputDecoration(
                    label: Text(reportType == ReportType.translation ? "Note (optional)" : "Description"),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: !textIsValid || (reportType == ReportType.bug && text.isEmpty) ? null : () => _submit(),
                  // onPressed: null,
                  // TODO: Replace with arb
                  child: const Text("Submit"),
                ),
              ],
            )),
      ),
    );
  }
}
