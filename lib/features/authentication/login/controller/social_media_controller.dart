import 'package:get/get.dart';
import 'package:mediplus/core/gloalctr.dart';

import '../../../../core/services/authentication/usecase.dart';
import '../../../../core/shared_widgets/alert_widget.dart';
import '../../../../core/shared_widgets/loading_widgets.dart';
import '../../../bottom_tab/screen/bottom_tab.dart';

class SocialMedialController extends GetxController {
  final AuthServices _authservices = AuthServices();

  googleSigin() async {
    showLoading(Get.context!);

    String res = await _authservices.signInWithGoogle();
    Get.back();
    if (res == 'success') {
      Get.offAll(() => BottomTab());
    } else {
      showErrorAlertWidget(Get.context!, message: res);
    }
  }
}
