import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownForm extends StatelessWidget {
  CustomDropDownForm({
    Key? key,
    required String selectedValue,
    required this.listOfValue,
    required this.header,
    required this.onChanged,
    this.headerStyle,
  })  : _selectedValue = selectedValue,
        super(key: key);

  final String _selectedValue;
  final List<String> listOfValue;

  final void Function(dynamic) onChanged;
  //final VoidCallback onChanged;

  final String header;
  final TextStyle? headerStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 4.h,
        ),
        DropdownButtonFormField(
          value: _selectedValue,
          hint: const Text(
            'choose one',
          ),
          isExpanded: true,
          onChanged: onChanged,
          onSaved: (value) {},
          validator: (value) {
            if (value == '') {
              return "can't empty";
            } else {
              return null;
            }
          },
          items: listOfValue.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
              constraints: BoxConstraints.expand(height: 56.h),
              contentPadding: EdgeInsets.symmetric(horizontal: 17.w),
              hintText: 'nvv',
              hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffBDBDBD)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      BorderSide(color: const Color(0xffBDBDBD), width: 1.w)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      BorderSide(color: const Color(0xffBDBDBD), width: 1.w))),
        )
      ],
    );
  }
}
