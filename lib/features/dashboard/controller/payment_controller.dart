import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mediplus/core/services/user/usecase.dart';

import '../../../core/services/user/model/service_model.dart';
import '../../../core/shared_widgets/alert_widget.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../env/private_key.dart';

class PaymentController extends GetxController {
  final UserServices _userServices = UserServices();

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

      showSuccessSnackBar('Payment', 'Payment Successful');
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
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

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Future<ServiceChargeModel> getServiceCharge() async {
    return await _userServices.getServiceCharge();
  }
}
