import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("الإشعارات", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: 5,
        separatorBuilder: (c, i) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return _buildNotificationItem(index);
        },
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    bool isUnread = index == 0;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: isUnread ? Border.all(color: AppColors.primary.withOpacity(0.2)) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isUnread ? AppColors.primary : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnread ? Icons.notifications_active : Icons.notifications_none,
              color: isUnread ? Colors.white : Colors.grey,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تحديث حالة الطلب",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.textPrimary),
                ),
                SizedBox(height: 4.h),
                Text(
                  "تم قبول طلب التحاقك بمدرسة المستقبل الدولية مبدئياً. يرجى استكمال الإجراءات.",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text("منذ 2 ساعة", style: TextStyle(color: Colors.grey[400], fontSize: 10.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
