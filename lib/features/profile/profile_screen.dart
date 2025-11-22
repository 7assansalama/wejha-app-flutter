import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // صورة البروفايل
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const NetworkImage("https://i.pravatar.cc/300"),
                  ),
                  SizedBox(height: 10.h),
                  Text("محمود أحمد", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  Text("mahmod@email.com", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // القائمة
            _buildProfileItem(Icons.person_outline, "تعديل الملف الشخصي"),
            _buildProfileItem(Icons.notifications_outlined, "الإشعارات"),
            _buildProfileItem(Icons.language, "لغة التطبيق"),
            _buildProfileItem(Icons.help_outline, "المساعدة والدعم"),
            
            SizedBox(height: 20.h),
            
            // زر تسجيل الخروج
            GestureDetector(
              onTap: () {
                // العودة لشاشة الدخول ومسح كل الصفحات السابقة من الذاكرة
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 16.w),
                    Text("تسجيل الخروج", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }
}
