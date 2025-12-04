import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../models/institute_model.dart'; // Assuming you have a model
import '../../widgets/primary_button.dart';
import '../apply/application_wizard_screen.dart';

class InstituteDetailsScreen extends StatefulWidget {
  // final String name;
  // final String image;
  // final String type; // مدرسة، جامعة، مركز تدريب
  final Institute institute;

  const InstituteDetailsScreen({
    super.key,
    required this.institute,
  });

  @override
  State<InstituteDetailsScreen> createState() => _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
  int _selectedTabIndex = 0; // 0: نظرة عامة، 1: البرامج/الدورات، 2: الآراء

  @override
  Widget build(BuildContext context) {
    // تحديد عنوان التاب الثاني بناءً على النوع
    String secondTabTitle = widget.institute.type == "مراكز تدريب"
        ? "الدورات التدريبية"
        : (widget.institute.type == "جامعات"
            ? "الكليات والتخصصات"
            : "المراحل الدراسية");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 1. الهيدر المتحرك (صورة الغلاف)
          SliverAppBar(
            expandedHeight: 250.h,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(widget.institute.image, fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.3)), // تظليل خفيف
                ],
              ),
            ),
          ),

          // 2. محتوى الصفحة
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
                  // العنوان والنوع
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.institute.name,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(widget.institute.type,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // شريط التبويبات (Tabs)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTabButton("نظرة عامة", 0),
                        SizedBox(width: 10.w),
                        _buildTabButton(secondTabTitle, 1),
                        SizedBox(width: 10.w),
                        _buildTabButton("الآراء والتقييمات", 2),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // عرض المحتوى حسب التاب المختار
                  _buildContent(),

                  SizedBox(height: 100.h), // مساحة فارغة في الأسفل
                ],
              ),
            ),
          ),
        ],
      ),

      // زر التقديم العائم في الأسفل
      bottomSheet: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("رسوم التقديم",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                Text("400 ر.س",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: PrimaryButton(
                text: "قدم طلب الآن",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApplicationWizardScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildProgramsTab();
      case 2:
        return _buildReviewsTab();
      default:
        return const SizedBox();
    }
  }

  // --- التاب 1: نظرة عامة ---
  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("نبذة عن المؤسسة",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text(
          "نسعى لتقديم أفضل مستوى تعليمي وتربوي لبناء جيل واعد ومبدع. تتميز مؤسستنا ببيئة تعليمية آمنة ومحفزة، وكادر تدريسي مؤهل، ومرافق حديثة.",
          style:
              TextStyle(fontSize: 14.sp, color: Colors.grey[700], height: 1.6),
        ),
        SizedBox(height: 24.h),
        Text("المميزات والخدمات",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _buildFeatureChip(Icons.directions_bus, "باص توصيل"),
            _buildFeatureChip(Icons.pool, "حمام سباحة"),
            _buildFeatureChip(Icons.language, "لغات متعددة"),
            _buildFeatureChip(Icons.computer, "معامل حاسب"),
            _buildFeatureChip(Icons.sports_soccer, "ملاعب رياضية"),
            _buildFeatureChip(Icons.security, "نظام أمان"),
          ],
        ),
        SizedBox(height: 24.h),
        Text("معرض الصور",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (c, i) => SizedBox(width: 10.w),
            itemBuilder: (c, i) => ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                "https://source.unsplash.com/random/200x200/?classroom,school,sig=$i",
                width: 120.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.primary),
          SizedBox(width: 6.w),
          Text(label,
              style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  // --- التاب 2: البرامج / المراحل (ديناميكي) ---
  Widget _buildProgramsTab() {
    // إذا كانت مدرسة -> نعرض المراحل الدراسية
    if (widget.institute.type == "مدارس" ||
        widget.institute.type == "رياض أطفال") {
      return Column(
        children: List.generate(
            4,
            (index) => _buildProgramCard(
                  title: "الصف الدراسي ${index + 1}",
                  subtitle: "الرسوم السنوية: ${15000 + (index * 1000)} ر.س",
                  icon: Icons.class_,
                )),
      );
    }
    // إذا كان مركز تدريب -> نعرض الدورات
    else if (widget.institute.type == "مراكز تدريب") {
      return Column(
        children: List.generate(
            3,
            (index) => _buildProgramCard(
                  title: "دورة اللغة الإنجليزية - المستوى ${index + 1}",
                  subtitle: "المدة: 4 أسابيع - السعر: 1200 ر.س",
                  icon: Icons.language,
                )),
      );
    }
    // إذا كانت جامعة -> نعرض الكليات
    else {
      return Column(
        children: [
          _buildProgramCard(
              title: "كلية الهندسة",
              subtitle: "5 سنوات - التخصصات: معماري، مدني، حاسبات",
              icon: Icons.architecture),
          _buildProgramCard(
              title: "كلية إدارة الأعمال",
              subtitle: "4 سنوات - التخصصات: تسويق، محاسبة",
              icon: Icons.business_center),
          _buildProgramCard(
              title: "كلية الفنون والتصميم",
              subtitle: "4 سنوات - التخصصات: جرافيك، ديكور",
              icon: Icons.palette),
        ],
      );
    }
  }

  Widget _buildProgramCard(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
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
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
        ],
      ),
    );
  }

  // --- التاب 3: الآراء والتقييمات ---
  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ملخص التقييم
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text("4.8",
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      children: List.generate(
                          5,
                          (index) => Icon(Icons.star,
                              color: Colors.amber, size: 18.sp))),
                  Text("بناءً على 120 تقييم",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // زر إضافة تقييم (للمستخدم)
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: فتح نافذة إضافة تقييم
            },
            icon: const Icon(Icons.edit),
            label: const Text("أضف تقييمك"),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // قائمة التعليقات
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=${index + 5}"),
                    radius: 20.r,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("محمد علي",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp)),
                            Text("منذ يومين",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.grey)),
                          ],
                        ),
                        Row(
                            children: List.generate(
                                5,
                                (i) => Icon(Icons.star,
                                    size: 12.sp,
                                    color: i < 4
                                        ? Colors.amber
                                        : Colors.grey[300]))),
                        SizedBox(height: 6.h),
                        Text(
                          "مدرسة ممتازة وإدارتها متعاونة جداً. الملاعب واسعة والأنشطة متنوعة. أنصح بها.",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[800],
                              height: 1.4),
                        ),
                        Divider(color: Colors.grey[200], height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
