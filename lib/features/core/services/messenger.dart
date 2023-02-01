import 'dart:io';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/disconnected_dialog.dart';
import 'package:vocabualize/features/core/widgets/save_message_route.dart';
import 'package:vocabualize/features/home/screens/home.dart';

class Messenger {
  static void loadingAnimation() {
    showDialog(
      context: Global.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      showAnimatedDialog(const DisconnectedDialog());
      return false;
    } on SocketException catch (_) {
      showAnimatedDialog(const DisconnectedDialog());
      return false;
    }
  }

  static Future<void> showSaveMessage(Vocabulary vocabulary) async {
    Navigator.popUntil(Global.context, ModalRoute.withName(Home.routeName)); // required, pops all messages
    Navigator.push(Global.context, SaveMessageRoute(vocabulary: vocabulary));
  }

  static Future<dynamic> showAnimatedDialog(Widget dialog) async {
    return await showGeneralDialog(
      context: Global.context,
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = const ElasticOutCurve(0.9).transform(animation1.value) - 1.0;
        return Transform(transform: Matrix4.translationValues(0, curvedValue * 200, 0), child: dialog);
      },
    );
  }
}
