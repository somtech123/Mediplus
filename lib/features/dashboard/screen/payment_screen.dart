import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';
import 'package:mediplus/features/dashboard/controller/payment_controller.dart';

import '../../../core/services/user/model/service_model.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../../../core/utlis/utlis.dart';
import '../../bottom_tab/screen/bottom_tab.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  var ctr = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        //iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: const Text(
          "Check Out",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: FutureBuilder(
          future: ctr.getServiceCharge(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                child: ShimmerManager.sectionShimmer(context),
                height: 200.h,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              return _checkOut(context, serviceCharge: snapshot.data!);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _checkOut(BuildContext context,
      {required ServiceChargeModel serviceCharge}) {
    int amount = int.parse(serviceCharge.servicesCharge.toString()) +
        int.parse(ctr.doc.fee.toString());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total:\t',
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColor.greyColor),
                ),
                Text('N ${currencyFormat.format(amount)}')
              ],
            ),
            SizedBox(height: 20.h),
            _buildExpansionContainer(context,
                paymentChannel: 'PayStack',
                text:
                    'You are about to make a payment of N ${currencyFormat.format(amount)} via PayStack',
                ontap: () {
              ctr.paystackCheckout(amount: amount.toString());
            }),
            SizedBox(height: 20.h),
            _buildExpansionContainer(context,
                paymentChannel: 'Stripe',
                text:
                    'You are about to make a payment of N ${currencyFormat.format(amount)} via Stripe',
                ontap: () {
              ctr.makePayment(amount: amount.toString(), currency: 'NGN');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionContainer(
    BuildContext context, {
    required String paymentChannel,
    required String text,
    required VoidCallback ontap,
  }) {
    return Container(
        width: Get.width,
        color: Colors.grey[100],
        child: ExpansionTile(
          trailing: const Icon(Icons.arrow_drop_down,
              color: AppColor.greyColor, size: 22),
          title: Text(paymentChannel,
              style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: AppColor.greyColor)),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: Get.width,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Color(0xff818181)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: PrimaryButton(label: 'Pay', onPressed: ontap),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
