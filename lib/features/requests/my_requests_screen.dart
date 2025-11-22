import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("طلباتي", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // نخفي سهم الرجوع لأنها في الشريط السفلي
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 3, // عدد وهمي للتجربة
        itemBuilder: (context, index) {
          return _buildRequestCard(index);
        },
      ),
    );
  }

  Widget _buildRequestCard(int index) {
    // حالات وهمية للتجربة (مقبول، قيد المراجعة، مرفوض)
    String status = index == 0 ? "مقبول" : (index == 1 ? "قيد المراجعة" : "مرفوض");
    Color statusColor = index == 0 ? Colors.green : (index == 1 ? Colors.orange : Colors.red);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // صورة المؤسسة
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: const DecorationImage(
                    image: NetworkImage("https://source.unsplash.com/random/100x100/?school"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("مدرسة المستقبل الدولية", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    SizedBox(height: 4.h),
                    Text("طلب التحاق - Grade 5", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                    SizedBox(height: 4.h),
                    Text("19 نوفمبر 2025", style: TextStyle(color: Colors.grey[400], fontSize: 10.sp)),
                  ],
                ),
              ),
              // حالة الطلب (Badge)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
