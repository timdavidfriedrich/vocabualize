import 'package:flutter/material.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/info_dialog.dart';
import 'package:vocabualize/features/core/widgets/save_message_route.dart';
import 'package:vocabualize/features/home/screens/home.dart';

class Messenger {
  static void loadingAnimation() {
    showDialog(
      context: Keys.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static void showSaveMessage(Vocabulary vocabulary) async {
    Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName)); // required, pops all messages
    Navigator.push(Keys.context, SaveMessageRoute(vocabulary: vocabulary));
  }

  static void infoDialog(Vocabulary vocabulary) {
    showGeneralDialog(
      context: Keys.context,
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = const ElasticOutCurve(0.9).transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0, curvedValue * 200, 0),
          child: InfoDialog(vocabulary: vocabulary),
        );
      },
    );
  }
}
