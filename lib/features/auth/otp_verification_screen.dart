import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (_) => FocusNode());
    _controllers = List.generate(4, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return _buildOtpDigit(
                  context: context,
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  nextFocusNode: index < 3 ? _focusNodes[index + 1] : null,
                );
              }),
            ),

            SizedBox(height: 30.h),
            const Text("إعادة الإرسال في 00:30",
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

  Widget _buildOtpDigit({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
  }) {
    return SizedBox(
      width: 60.w,
      height: 60.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "", // لإخفاء عداد الأحرف
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}
