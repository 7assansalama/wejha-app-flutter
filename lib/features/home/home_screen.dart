import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/institute_card.dart';
import '../details/institute_details_screen.dart';
import '../../models/institute_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "الكل";

  final List<Institute> _allInstitutes = const [
    Institute(
      name: "مدرسة المستقبل الدولية",
      address: "القاهرة الجديدة، التجمع الخامس",
      rating: 4.8,
      image: "https://images.unsplash.com/photo-1580582932707-520aed93a94d?w=500",
      type: "مدارس",
      isFeatured: true,
    ),
    Institute(
      name: "جامعة الصفوة",
      address: "6 أكتوبر، الحي المتميز",
      rating: 4.5,
      image: "https://images.unsplash.com/photo-1562774053-701939374585?w=500",
      type: "جامعات",
      isFeatured: false,
    ),
    Institute(
      name: "حضانة البراعم الصغيرة",
      address: "المعادي، شارع 9",
      rating: 4.9,
      image: "https://images.unsplash.com/photo-1587654780291-39c940483713?w=500",
      type: "رياض أطفال",
      isFeatured: false,
    ),
    Institute(
      name: "مركز نيوهورايزون للتدريب",
      address: "الدقي، الجيزة",
      rating: 4.2,
      image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=500",
      type: "مراكز تدريب",
      isFeatured: false,
    ),
    Institute(
      name: "مدرسة النيل المصرية",
      address: "العبور، القليوبية",
      rating: 4.6,
      image: "https://images.unsplash.com/photo-1546410531-bb4caa6b424d?w=500",
      type: "مدارس",
      isFeatured: false,
    ),
  ];

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedCategory == "الكل"
        ? _allInstitutes
        : _allInstitutes.where((item) => item.type == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Header(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _CategoryFilters(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _onCategorySelected,
                  ),
                  SizedBox(height: 24.h),
                  _SectionHeader(selectedCategory: _selectedCategory),
                  _InstituteList(filteredList: filteredList),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Separated Widgets ---

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w, bottom: 30.h),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const _AppBarContent(),
          SizedBox(height: 20.h),
          const _SearchField(),
        ],
      ),
    );
  }
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("الموقع الحالي", style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
            Row(
              children: [
                Text("القاهرة، مصر", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: Colors.white.withAlpha(51), shape: BoxShape.circle),
          child: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "اكتب ما تبحث عنه...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const _CategoryFilters({required this.selectedCategory, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip("الكل", Icons.apps),
          _buildFilterChip("مدارس", Icons.school_outlined),
          _buildFilterChip("جامعات", Icons.account_balance_outlined),
          _buildFilterChip("مراكز تدريب", Icons.cast_for_education),
          _buildFilterChip("رياض أطفال", Icons.child_care),
        ].expand((widget) => [widget, SizedBox(width: 10.w)]).toList()..removeLast(),
      ),
    );
  }

  Widget _buildFilterChip(String title, IconData icon) {
    bool isSelected = selectedCategory == title;
    return GestureDetector(
      onTap: () => onCategorySelected(title),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
            ),
            child: Icon(icon, color: isSelected ? Colors.white : AppColors.primary, size: 28.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String selectedCategory;
  const _SectionHeader({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedCategory == "الكل" ? "الأكثر اختياراً" : "نتائج $selectedCategory",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        if (selectedCategory == "الكل")
          TextButton(
            onPressed: () {},
            child: const Text("عرض الكل", style: TextStyle(color: AppColors.primary)),
          ),
      ],
    );
  }
}

class _InstituteList extends StatelessWidget {
  final List<Institute> filteredList;
  const _InstituteList({required this.filteredList});

  @override
  Widget build(BuildContext context) {
    if (filteredList.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: Text("لا توجد نتائج في هذا التصنيف")),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
        return InstituteCard(
          name: item.name,
          address: item.address,
          rating: item.rating,
          isFeatured: item.isFeatured,
          imagePath: item.image,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InstituteDetailsScreen(
                  name: item.name,
                  image: item.image,
                  type: item.type,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
