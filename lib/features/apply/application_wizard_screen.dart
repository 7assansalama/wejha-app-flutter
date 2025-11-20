
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../payment/payment_screen.dart';

class ApplicationWizardScreen extends StatefulWidget {
  const ApplicationWizardScreen({super.key});

  @override
  State<ApplicationWizardScreen> createState() => _ApplicationWizardScreenState();
}

class _ApplicationWizardScreenState extends State<ApplicationWizardScreen> {
  int _currentStep = 0; // 0: طالب, 1: ولي أمر, 2: مؤهلات, 3: وثائق

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("استمارة التقديم", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          _buildStepperHeader(),
          SizedBox(height: 24.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildCurrentStepContent(),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepIcon(0, Icons.person_outline, "الطالب"),
          _stepLine(0),
          _stepIcon(1, Icons.people_outline, "ولي الأمر"),
          _stepLine(1),
          _stepIcon(2, Icons.school_outlined, "المؤهلات"),
          _stepLine(2),
          _stepIcon(3, Icons.description_outlined, "الوثائق"),
        ],
      ),
    );
  }

  Widget _stepIcon(int index, IconData icon, String label) {
    bool isActive = _currentStep >= index;
    bool isCurrent = _currentStep == index;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300),
          ),
          child: Icon(
            isActive ? Icons.check : icon,
            color: isActive ? Colors.white : Colors.grey,
            size: 20.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: isCurrent ? AppColors.primary : Colors.grey,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _stepLine(int index) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: _currentStep > index ? AppColors.primary : Colors.grey.shade300,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 15.h),
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _step1StudentInfo();
      case 1:
        return _step2ParentInfo();
      case 2:
        return _step3AcademicInfo();
      case 3:
        return _step4Documents();
      default:
        return Container();
    }
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(20.w),
      color: Colors.white,
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: OutlinedButton(
                  onPressed: () => setState(() => _currentStep--),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text("السابق", style: TextStyle(color: AppColors.primary, fontSize: 16.sp)),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              text: _currentStep == 3 ? "دفع وإرسال" : "استمرار",
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentScreen()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _step1StudentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("البيانات الشخصية", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 16.h),
        const CustomTextField(hintText: "اسم الطالب بالكامل (كما في الجواز)"),
        _buildPhoneField(),
        _buildSelectField("تاريخ الميلاد", Icons.calendar_today_outlined),
        _buildSelectField("الجنسية", Icons.flag_outlined),
        const CustomTextField(hintText: "العنوان بالتفصيل"),
        const CustomTextField(hintText: "الرقم القومي / رقم جواز السفر"),
      ],
    );
  }

  Widget _step2ParentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("بيانات التواصل", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text("يرجى إدخال بيانات ولي الأمر للتواصل في حالة الطوارئ", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        SizedBox(height: 20.h),
        const CustomTextField(hintText: "اسم ولي الأمر رباعي"),
        _buildSelectField("صلة القرابة (أب / أم / وصي)", Icons.people_alt_outlined),
        _buildPhoneField(),
        const CustomTextField(hintText: "البريد الإلكتروني لولي الأمر", keyboardType: TextInputType.emailAddress),
        const CustomTextField(hintText: "الوظيفة"),
        const CustomTextField(hintText: "جهة العمل"),
      ],
    );
  }

  Widget _step3AcademicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الخلفية التعليمية", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 16.h),
        const CustomTextField(hintText: "اسم المدرسة / الجامعة السابقة"),
        _buildSelectField("سنة التخرج", Icons.calendar_month),
        _buildSelectField("نوع الشهادة (ثانوية عامة / IGCSE / American)", Icons.school),
        const CustomTextField(hintText: "المجموع / المعدل التراكمي (GPA)", keyboardType: TextInputType.number),
        const CustomTextField(hintText: "رقم الجلوس (اختياري)"),
      ],
    );
  }

  Widget _step4Documents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("المرفقات المطلوبة", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text("يرجى رفع صور واضحة للمستندات التالية", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        SizedBox(height: 20.h),
        _buildUploadCard("الصورة الشخصية", true),
        _buildUploadCard("صورة شهادة الميلاد", true),
        _buildUploadCard("صورة البطاقة / جواز السفر", true),
        _buildUploadCard("آخر شهادة دراسية", true),
        _buildUploadCard("شهادة التطعيمات (للمدارس)", false),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
                hintText: "رقم الجوال",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectField(String hint, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint, style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp)),
          Icon(icon, color: Colors.grey, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildUploadCard(String title, bool isRequired) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  if (isRequired)
                    const Text(" *", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 4.h),
              Text("JPEG, PNG, PDF (Max 5MB)", style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.cloud_upload_outlined, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
