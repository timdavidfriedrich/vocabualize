import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/screens/home.dart';
import 'package:vocabualize/screens/record_sheet.dart';
import 'package:vocabualize/utils/providers/visible_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/providers/lang_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => VocProv()),
      ChangeNotifierProvider(create: (context) => LangProv()),
      ChangeNotifierProvider(create: (context) => VisibleProv()),
    ], child: const ThemeHandler(home: SnappingLayout()));
  }
}

class SnappingLayout extends StatelessWidget {
  const SnappingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: SnappingSheet(
            snappingPositions: const [
              SnappingPosition.factor(
                  positionFactor: 0.0,
                  snappingCurve: Curves.elasticOut,
                  snappingDuration: Duration(milliseconds: 1000),
                  grabbingContentOffset: GrabbingContentOffset.top),
              SnappingPosition.factor(
                positionFactor: 0.75,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
            ],
            grabbing: const RecordGrab(),
            grabbingHeight: 64,
            sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
            child: Provider.of<VocProv>(context).getVocabularyList().isEmpty ? const HomeEmpty() : const Home(),
          ),
        ),
      ),
    );
  }
}
