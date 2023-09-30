import 'dart:convert';
import 'dart:io';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:mediplus/core/services/user/usecase.dart';

import '../../../core/gloalctr.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/services/user/model/service_model.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../env/private_key.dart';
import '../../bottom_tab/screen/bottom_tab.dart';

class PaymentController extends GetxController {
  final UserServices _userServices = UserServices();

  DoctorModel doc = Get.arguments;

  var globalCtr = Get.find<GlobalController>();
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              customFlow: true,
              allowsDelayedPaymentMethods: true,
              merchantDisplayName: 'Mediplus',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
            ))
            .then((value) {});
        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Get.offAll(() => BottomTab());

      showSuccessSnackBar('Payment', 'Payment Successful');
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");

        showErrorAlertWidget(Get.context!,
            message: ' ${e.error.localizedMessage}');
      } else {
        print("Unforeseen error: ${e}");

        showErrorAlertWidget(Get.context!, message: "Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");

      showErrorAlertWidget(Get.context!, message: '$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${PrivateKey.stripePrivateKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final errorMessage = jsonDecode(response.body)["error"]["message"];

        return showErrorAlertWidget(Get.context!, message: errorMessage);
      }
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  int calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a;
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<ServiceChargeModel> getServiceCharge() async {
    return await _userServices.getServiceCharge();
  }

  final plugin = PaystackPlugin();

  paystackCheckout({required String amount}) async {
    Charge charge = Charge()
      ..amount = calculateAmount(amount)
      //..accessCode = 'AUTH_6tmt288t0o'
      //PrivateKey.pasystackPrivateKey
      ..email = globalCtr.user.value.email
      ..reference = _getReference()
      ..currency = "NGN";

    CheckoutResponse response = await plugin.checkout(
      Get.context!,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.message == 'Success') {
      Get.offAll(() => const BottomTab());

      showSuccessSnackBar('Payment', 'Payment Successful');
    } else {
      showErrorAlertWidget(Get.context!, message: response.message);
    }
  }

  @override
  void onInit() {
    plugin.initialize(publicKey: PrivateKey.payStackPublicKey);
    super.onInit();
  }
}
