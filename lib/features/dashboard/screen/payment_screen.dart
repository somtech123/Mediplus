import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';
import 'package:mediplus/features/dashboard/controller/payment_controller.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  var ctr = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: const Text(
          "Check Out",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                  Text('6000')
                ],
              ),
              SizedBox(height: 20.h),
              _buildExpansionContainer(context,
                  paymentChannel: 'Flutterwave',
                  text:
                      'You are about to make a payment of N600 via Flutterwave',
                  ontap: () {}),
              SizedBox(height: 20.h),
              _buildExpansionContainer(context,
                  paymentChannel: 'Stripe',
                  text: 'You are about to make a payment of N600 via Stripe',
                  ontap: () {
                ctr.makePayment(amount: '6', currency: 'USD');
              }),
            ],
          ),
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
