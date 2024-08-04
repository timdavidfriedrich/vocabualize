import 'dart:io';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/presentation/widgets/disconnected_dialog.dart';

class HelperWidgets {
  // TODO ARCHITECTURE: Remove from this class and create a new file in presentation
  static void loadingAnimation() {
    showDialog(
      context: Global.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  // TODO ARCHITECTURE: Move connection checking to a util file and move ui elements to presentation layer
  static Future<bool> showDisconnectedDialogIfNecessary() async {
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

  // TODO ARCHITECTURE: Remove from this class and create a new file in presentation (Maybe remove completely)
  static Future<dynamic> showStaticDialog(Widget dialog) async {
    return await showDialog(
      context: Global.context,
      builder: (context) {
        return dialog;
      },
    );
  }
}
