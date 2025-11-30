import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/app_colors.dart';
import 'primary_button.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  // قيم افتراضية للفلتر
  String _schoolType = "خاصة";
  double _priceRange = 20000;
  bool _hasBus = false;
  bool _hasPool = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          // مقبض السحب
          Center(
            child: Container(
              width: 50.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
          SizedBox(height: 20.h),

          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("تصفية النتائج",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context)),
            ],
          ),
          Divider(color: Colors.grey[200]),

          // 1. نوع المدرسة
          _buildSectionTitle("نوع المؤسسة"),
          Row(
            children: [
              _buildRadioOption("حكومية", _schoolType),
              SizedBox(width: 10.w),
              _buildRadioOption("خاصة", _schoolType),
              SizedBox(width: 10.w),
              _buildRadioOption("دولية", _schoolType),
            ],
          ),

          // 2. المدى السعري
          _buildSectionTitle(
              "الحد الأقصى للمصاريف: ${_priceRange.toInt()} ر.س"),
          Slider(
            value: _priceRange,
            min: 5000,
            max: 100000,
            divisions: 20,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _priceRange = val),
          ),

          // 3. المرافق (Checkboxes)
          _buildSectionTitle("المرافق والخدمات"),
          _buildSwitchOption(
              "باص توصيل", _hasBus, (val) => setState(() => _hasBus = val)),
          _buildSwitchOption(
              "حمام سباحة", _hasPool, (val) => setState(() => _hasPool = val)),

          SizedBox(height: 30.h),

          // أزرار التحكم
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // إعادة تعيين
                    setState(() {
                      _schoolType = "خاصة";
                      _priceRange = 20000;
                      _hasBus = false;
                      _hasPool = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text("إعادة تعيين",
                      style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: "تطبيق النتائج",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800])),
    );
  }

  Widget _buildRadioOption(String label, String groupValue) {
    return GestureDetector(
      onTap: () => setState(() => _schoolType = label),
      child: Chip(
        label: Text(label),
        backgroundColor: groupValue == label
            ? AppColors.primary.withOpacity(0.1)
            : Colors.grey[100],
        labelStyle: TextStyle(
          color: groupValue == label ? AppColors.primary : Colors.black,
          fontWeight: groupValue == label ? FontWeight.bold : FontWeight.normal,
        ),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildSwitchOption(
      String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp)),
        Switch(
          value: value,
          activeThumbColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
