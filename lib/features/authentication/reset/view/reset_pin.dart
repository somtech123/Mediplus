
// class VweificationScreen extends StatelessWidget {
//   VweificationScreen({super.key});

//   var ctr = Get.put(VerificationController());

//   BoxDecoration get _pinPutDecoration {
//     return BoxDecoration(
//       color: AppColors.secondary.withOpacity(.1),
//     );
//   }

//   final FocusNode _pinPutFocusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         titleSpacing: 0.0,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: AppColors.black),
//         title: Text(
//           "back",
//           style: Theme.of(context).textTheme.button!.copyWith(
//               color: AppColors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 31.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 26.h,
//               ),

//               SizedBox(
//                 height: 81.h,
//               ),
//               // Center(
//               //   child: Image.asset(
//               //     'assets/images/verification_image.png',
//               //     height: 171.67.h,
//               //     width: 162.18.h,
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//               SizedBox(
//                 height: 48.h,
//               ),
//               Center(
//                 child: Text('Mail Verification',
//                     style: Theme.of(context).textTheme.caption!.copyWith(
//                         color: Color(0xff292929),
//                         fontSize: 28,
//                         fontWeight: FontWeight.w700)),
//               ),
//               SizedBox(
//                 height: 16.h,
//               ),
//               Center(
//                 child: Text(
//                     'We sent you a 6-digit code. Please enter otp sent to ${ctr.email}',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.caption!.copyWith(
//                         color: Color(0xff7D7D7D),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400)),
//               ),
//               SizedBox(
//                 height: 56.h,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: Pinput(
//                     controller: ctr.otpController,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     defaultPinTheme: PinTheme(
//                       decoration: _pinPutDecoration,
//                       width: Get.width * .15,
//                       height: 50,
//                       constraints: BoxConstraints(
//                           minHeight: 50.0, minWidth: Get.width * .15),
//                       margin: EdgeInsets.only(right: 10),
//                     ),
//                     submittedPinTheme: PinTheme(
//                         width: Get.width * .15,
//                         height: 50,
//                         constraints: BoxConstraints(
//                             minHeight: 50.0, minWidth: Get.width * .15),
//                         decoration: _pinPutDecoration.copyWith(
//                           borderRadius: BorderRadius.circular(20.0),
//                         )),
//                     focusedPinTheme: PinTheme(
//                       decoration: _pinPutDecoration,
//                       width: Get.width * .15,
//                       height: 50,
//                       constraints: BoxConstraints(
//                           minHeight: 50.0, minWidth: Get.width * .15),
//                     ),
//                     followingPinTheme: PinTheme(
//                         width: Get.width * .15,
//                         height: 50,
//                         constraints: BoxConstraints(
//                             minHeight: 50.0, minWidth: Get.width * .15),
//                         decoration: _pinPutDecoration.copyWith(
//                           borderRadius: BorderRadius.circular(5.0),
//                           border: Border.all(
//                             color: Get.isDarkMode
//                                 ? AppColors.black
//                                 : Colors.grey[300]!,
//                           ),
//                         )),
//                     length: 6,
//                     onSubmitted: (String pin) => debugPrint(pin),
//                     focusNode: _pinPutFocusNode,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 51.h,
//               ),
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                       text: 'Didn’t receive any otp?',
//                       children: [
//                         TextSpan(
//                             text: ' Resend Otp',
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 //  ctr.resendOtp();
//                               },
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption!
//                                 .copyWith(
//                                     color: AppColors.secondary,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w700)),
//                       ],
//                       style: Theme.of(context)
//                           .textTheme
//                           .caption!
//                           .copyWith(fontSize: 18, fontWeight: FontWeight.w400)),
//                 ),
//               ),
//               SizedBox(
//                 height: 95.h,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 64,
//                 child: PrimaryButton(
//                   label: 'Verify',
//                   onPressed: () {
//                     ctr.verifyEmail();
//                   },
//                   backgroundColor: AppColors.secondary,
//                 ),
//               ),
//               SizedBox(
//                 height: 50.h,
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
