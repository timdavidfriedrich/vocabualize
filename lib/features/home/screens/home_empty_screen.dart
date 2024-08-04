import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/reports/screens/report_screen.dart';
import 'package:vocabualize/features/reports/utils/report_arguments.dart';
import 'package:vocabualize/features/settings/screens/settings_screen.dart';

// TODO: Refactor to minimize code redundancy
class HomeEmptyScreen extends StatelessWidget {
  const HomeEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openReportPage() {
      Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportArguments.bug());
    }

    void showSettings() {
      Navigator.pushNamed(context, SettingsScreen.routeName);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(CommonConstants.appName, style: Theme.of(context).textTheme.headlineLarge),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(onPressed: () => openReportPage(), icon: const Icon(Icons.bug_report_rounded)),
              IconButton(onPressed: () => showSettings(), icon: const Icon(Icons.settings_rounded)),
            ],
          ),
          // image from assets
          const Spacer(),
          Image.asset(
            AssetPath.mascotSave,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 16),
          const Text(
            // TODO: Replace with arb
            "Swipe up to add\nyour first word.",
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
