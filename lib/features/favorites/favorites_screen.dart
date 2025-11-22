import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/institute_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("المفضلة", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 2,
        itemBuilder: (context, index) {
          return InstituteCard(
            name: "جامعة الصفوة",
            address: "6 أكتوبر، الحي المتميز",
            rating: 4.5,
            imagePath: "https://images.unsplash.com/photo-1562774053-701939374585?w=500",
            isFeatured: false,
            onTap: () {
              // يمكننا إضافة الانتقال للتفاصيل هنا
            },
          );
        },
      ),
    );
  }
}
