import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../../../core/shared_widgets/app_textfield.dart';
import '../../../core/shared_widgets/custom_drop_down.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../../authentication/widget/phone_text_field.dart';
import '../controller/edit_profile_controller.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var ctr = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: Text("Update Profile",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColor.blackColor, fontSize: 15)),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                labelText: 'First name',
                min: true,
                controller: ctr.fnameController,
                errorMessage: ctr.fnameErrorText.value,
                onChanged: (p0) => ctr.clearError(ctr.fnameErrorText),
              ),
              AppTextField(
                labelText: 'Last Name',
                min: true,
                controller: ctr.lnameController,
                errorMessage: ctr.lnameErrorText.value,
                onChanged: (p0) => ctr.clearError(ctr.lnameErrorText),
              ),
              AppTextField(
                labelText: 'UserName',
                min: true,
                controller: ctr.usernamenameController,
                errorMessage: ctr.usernamenameErrorText.value,
                onChanged: (p0) => ctr.clearError(ctr.usernamenameErrorText),
              ),
              InkWell(
                onTap: () => ctr.selectDate(context),
                child: AbsorbPointer(
                  absorbing: true,
                  child: AppTextField(
                    labelText: 'Date of birth',
                    min: true,
                    controller: ctr.dateController,
                    errorMessage: ctr.dateErrorText.value,
                    onChanged: (p0) => ctr.clearError(ctr.dateErrorText),
                    suffix: const Icon(Icons.calendar_month,
                        size: 16, color: AppColor.blackColor),
                  ),
                ),
              ),
              RadioGroup<String>.builder(
                direction: Axis.vertical,
                textStyle:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
                groupValue: ctr.gender.value,
                activeColor: AppColor.primaryColor,
                onChanged: (value) {
                  ctr.setGender(value!);
                },
                items: const ['Male', 'Female', 'others'],
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: PhoneTextField(
                  controller: ctr.phoneController,
                  errorMessage: ctr.phoneErrorText.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: AbsorbPointer(
                        absorbing: false,
                        child: CustomDropDownForm(
                          selectedValue: ctr.selectedCountry.value,
                          listOfValue: ctr.location
                              .map((element) => element.country)
                              .toList(),
                          header: 'Country',
                          onChanged: (p) {
                            ctr.onCountrySelected(p);
                            debugPrint(p);
                          },
                          headerStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.11),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.w,
                      child: AbsorbPointer(
                        absorbing: false,
                        child: CustomDropDownForm(
                          selectedValue: ctr.selectedState.value,
                          listOfValue: ctr.location
                              .firstWhere((element) =>
                                  element.country == ctr.selectedCountry.value)
                              .states,
                          header: 'State',
                          onChanged: (p) {
                            ctr.onStateSelected(p);
                            debugPrint(p);
                          },
                          headerStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PrimaryButton(
                  label: 'Update Profile',
                  onPressed: () {
                    ctr.validate();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
