import 'dart:io';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/widgets/start.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/disconnected_dialog.dart';
import 'package:vocabualize/features/core/widgets/save_message_route.dart';

class MessangingService {
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
      // TODO: Not only check for google, since this method's not working
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      showStaticDialog(const DisconnectedDialog());
      return false;
    } on SocketException catch (_) {
      showStaticDialog(const DisconnectedDialog());
      return false;
    }
  }

  static Future<void> showSaveMessage(Vocabulary vocabulary) async {
    Navigator.popUntil(Global.context, ModalRoute.withName(Start.routeName)); // required, pops all messages
    Navigator.push(Global.context, SaveMessageRoute(vocabulary: vocabulary));
  }

  // TODO: Perhaps, remove this from Messenger
  static Future<dynamic> showStaticDialog(Widget dialog) async {
    return await showDialog(
      context: Global.context,
      builder: (context) {
        return dialog;
      },
    );
  }

  // TODO: Remove animated dialog or decide something else
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
