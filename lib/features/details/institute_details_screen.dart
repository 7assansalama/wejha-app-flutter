import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../apply/application_wizard_screen.dart';

class InstituteDetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String type; // مدرسة، جامعة، مركز تدريب

  const InstituteDetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.type,
  });

  @override
  State<InstituteDetailsScreen> createState() => _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
  int _selectedTabIndex = 0; // عشان نعرف احنا في انهي تاب

  @override
  Widget build(BuildContext context) {
    // تحديد اسم التاب الثاني بناءً على النوع
    String programsTabTitle = widget.type == "مراكز تدريب"
        ? "الدورات"
        : (widget.type == "جامعات" ? "الكليات" : "المراحل");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 1. الهيدر المتحرك
          SliverAppBar(
            expandedHeight: 250.h,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(widget.image, fit: BoxFit.cover),
            ),
          ),

          // 2. المحتوى المتغير
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم والنوع
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.type, style: TextStyle(color: AppColors.primary, fontSize: 14.sp)),
                  
                  SizedBox(height: 24.h),

                  // شريط التابات (Tabs)
                  Row(
                    children: [
                      _buildTabChip("نظرة عامة", 0),
                      SizedBox(width: 10.w),
                      _buildTabChip(programsTabTitle, 1), // الاسم المتغير
                      SizedBox(width: 10.w),
                      _buildTabChip("الآراء", 2),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // عرض المحتوى حسب التاب المختار
                  _buildContentBody(),
                  
                  SizedBox(height: 80.h), // مساحة للزر السفلي
                ],
              ),
            ),
          ),
        ],
      ),
      
      // زر التقديم
      bottomSheet: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("رسوم التقديم", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                Text("400 ر.س", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: PrimaryButton(
                text: "قدم طلب الآن",
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ApplicationWizardScreen()),
  );
},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء زرار التاب
  Widget _buildTabChip(String text, int index) {
    bool isActive = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // تغيير المحتوى عند الضغط
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // دالة تحديد المحتوى المعروض
  Widget _buildContentBody() {
    if (_selectedTabIndex == 0) {
      return _buildOverviewTab();
    } else if (_selectedTabIndex == 1) {
      return _buildProgramsTab();
    } else {
      return _buildReviewsTab();
    }
  }

  // --- محتوى التاب 1: نظرة عامة ---
  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("عن المؤسسة", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text(
          "تتميز هذه المؤسسة ببيئة تعليمية متطورة وتوفر أحدث الوسائل التكنولوجية لخدمة الطالب...",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700], height: 1.6),
        ),
        SizedBox(height: 20.h),
        Text("المميزات", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w, runSpacing: 10.h,
          children: [
            _featureChip(Icons.directions_bus, "باص"),
            _featureChip(Icons.pool, "حمام سباحة"),
            _featureChip(Icons.language, "لغات"),
          ],
        ),
      ],
    );
  }

  // --- محتوى التاب 2: المراحل / الدورات (الأهم) ---
  Widget _buildProgramsTab() {
    // هنا ممكن نغير الداتا بناء على widget.type لاحقاً
    return Column(
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  widget.type == "مراكز تدريب" ? Icons.class_ : Icons.school,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.type == "مراكز تدريب" 
                        ? "دورة اللغة الإنجليزية - مستوى $index" 
                        : "الصف الدراسي ${index + 1}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  Text(
                    widget.type == "مراكز تدريب" ? "30 ساعة تدريبية" : "المصاريف: 15,000 ر.س",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  // --- محتوى التاب 3: الآراء ---
  Widget _buildReviewsTab() {
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("أحمد محمد", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            Text("5.0", style: TextStyle(fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "تجربة ممتازة ومستوى تعليمي راقي جداً، أنصح بها بشدة.",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                    ),
                    Divider(color: Colors.grey.shade200),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _featureChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: AppColors.primary),
      label: Text(label, style: TextStyle(fontSize: 12.sp)),
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.grey.shade200),
    );
  }
}
