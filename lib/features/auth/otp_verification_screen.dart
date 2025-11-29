import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text("أدخل الرمز",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text(
              "تم إرسال رمز مكون من 4 أرقام إلى\n+966 55xxxxxxx",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14.sp, color: Colors.grey, height: 1.5),
            ),
            SizedBox(height: 40.h),

            // خانات الـ OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  4, (index) => _buildOtpDigit(index == 0)), // أول واحد نشط
            ),

            SizedBox(height: 30.h),
            Text("إعادة الإرسال في 00:30",
                style: TextStyle(color: AppColors.primary)),

            const Spacer(),

            PrimaryButton(
              text: "تحقق",
              onPressed: () {
                // رسالة نجاح والعودة
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("تم تغيير كلمة المرور بنجاح"),
                      backgroundColor: Colors.green),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpDigit(bool isActive) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive ? AppColors.primary : Colors.grey.shade300,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          isActive ? "5" : "",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
