import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../home/main_layout_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? _selectedRole; // لتحديد هل هو طالب أم ولي أمر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("استكمال البيانات", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "مرحباً بك! 👋\nنحتاج لبعض البيانات الإضافية لضبط تجربتك.",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700], height: 1.5),
            ),
            SizedBox(height: 30.h),

            // 1. رقم الجوال
            Text("رقم الجوال", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 8.h),
            Container(
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
                        Icon(Icons.flag, color: Colors.green, size: 20.sp),
                        SizedBox(width: 8.w),
                        const Text("+966", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 30.h, color: Colors.grey.shade300),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "55xxxxxxx",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 2. المدينة
            Text("المدينة", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 8.h),
            const CustomTextField(hintText: "الرياض، جدة، ..."),
            
            SizedBox(height: 20.h),

            // 3. نوع الحساب
            Text("أنا أبحث بصفتي:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(child: _buildRoleOption("طالب", Icons.school)),
                SizedBox(width: 15.w),
                Expanded(child: _buildRoleOption("ولي أمر", Icons.family_restroom)),
              ],
            ),

            const Spacer(),

            // زر الحفظ
            PrimaryButton(
              text: "حفظ وبدء الرحلة",
              onPressed: () {
                // نقل المستخدم للشاشة الرئيسية وحذف ما قبله
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
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

  Widget _buildRoleOption(String label, IconData icon) {
    bool isSelected = _selectedRole == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = label),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : Colors.grey),
            SizedBox(height: 5.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
