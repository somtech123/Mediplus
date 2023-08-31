import 'package:get/get.dart';

///
push<T>({required String page, T? argument, Map<String, String>? params}) {
  Get.toNamed(page, arguments: argument, parameters: params);
}

///
pushUntil<T>({required String page, T? argument, Map<String, String>? params}) {
  Get.offAllNamed(page, arguments: argument, parameters: params);
}

///
pushReplacement<T>(
    {required String page, T? argument, Map<String, String>? params}) {
  Get.offAndToNamed(page, arguments: argument, parameters: params);
}

///
pop<T>([dynamic args]) {
  Get.back<T>(result: args);
}
