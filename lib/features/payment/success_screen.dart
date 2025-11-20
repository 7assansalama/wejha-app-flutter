import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../home/main_layout_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // دائرة النجاح المتحركة (مؤقتاً أيقونة)
            Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, size: 80.sp, color: AppColors.success),
            ),
            SizedBox(height: 40.h),
            Text(
              "عملية ناجحة!",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            SizedBox(height: 12.h),
            Text(
              "تمت عملية الدفع وإرسال طلبك بنجاح.\nسيتم التواصل معك في أقرب وقت.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey, height: 1.5),
            ),
            const Spacer(),
            PrimaryButton(
              text: "الذهاب للرئيسية",
              onPressed: () {
                // مسح كل الصفحات والعودة للرئيسية
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
                  (route) => false,
                );
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
