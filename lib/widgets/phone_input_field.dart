import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class PhoneInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const PhoneInputField({
    super.key,
    this.hintText = "اكتب رقم الجوال",
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Row(
              children: [
                Icon(Icons.flag_circle,
                    color: Colors.green.shade700, size: 20.sp),
                SizedBox(width: 8.w),
                const Text("+966",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
          Container(width: 1, height: 30.h, color: Colors.grey.shade300),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                hintStyle:
                    TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
