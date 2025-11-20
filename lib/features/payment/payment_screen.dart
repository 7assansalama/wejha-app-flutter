import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedCard = 0; // الكارت المختار افتراضياً

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("إتمام الدفع", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. ملخص المبلغ
            Center(
              child: Column(
                children: [
                  Text("قيمة الدفع", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  Text("400.00 ر.س", style: TextStyle(color: AppColors.primary, fontSize: 32.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // 2. قائمة الكروت المحفوظة
            Text("بطاقات الدفع", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            
            _buildPaymentCard(0, "Visa", "**** **** **** 5131", Colors.black),
            _buildPaymentCard(1, "MasterCard", "**** **** **** 9800", Colors.blue[900]!),

            // 3. زر إضافة بطاقة جديدة
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: AppColors.primary),
                    SizedBox(width: 8.w),
                    const Text("اضف بطاقة جديدة", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            
            const Spacer(),

            // 4. زر التأكيد
            PrimaryButton(
              text: "تأكيد الدفع",
              onPressed: () {
                // الانتقال لشاشة النجاح
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(int index, String type, String number, Color color) {
    bool isSelected = _selectedCard == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCard = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent, 
            width: 2
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            SizedBox(width: 16.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r)),
              child: Text(type, style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 16.w),
            Text(number, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
