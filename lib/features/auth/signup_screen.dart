import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/phone_input_field.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      appBar: _SignupAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              _Header(),
              SizedBox(height: 32.0),
              _SignupForm(),
              SizedBox(height: 24.0),
              _SocialLoginDivider(),
              SizedBox(height: 24.0),
              _SocialButtons(),
              SizedBox(height: 48.0),
              _LoginRedirect(),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Separated Widgets ---

class _SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SignupAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(color: AppColors.textPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "أنشئ حساباً جديداً",
          style: textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "ادخل بياناتك لبدء رحلتك معنا",
          style:
              textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _SignupForm extends StatefulWidget {
  const _SignupForm();

  @override
  __SignupFormState createState() => __SignupFormState();
}

class __SignupFormState extends State<_SignupForm> {
  bool _isObscure = true;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: "الاسم الكامل",
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: 16.h),
        PhoneInputField(),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: "كلمة المرور",
          obscureText: _isObscure,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            icon: Icon(_isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined),
            onPressed: () => setState(() => _isObscure = !_isObscure),
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTermsAndConditions(),
        SizedBox(height: 24.h),
        PrimaryButton(
          text: "إنشاء حساب",
          onPressed: _agreedToTerms ? () {/* TODO: Signup */} : null,
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            value: _agreedToTerms,
            activeColor: AppColors.primary,
            onChanged: (value) => setState(() => _agreedToTerms = value!),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: const [
                TextSpan(text: "أوافق على "),
                TextSpan(
                  text: "الشروط والأحكام",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  // TODO: Add recognizer for terms.
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialLoginDivider extends StatelessWidget {
  const _SocialLoginDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 0.5)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text("أو التسجيل بواسطة",
              style: Theme.of(context).textTheme.bodySmall),
        ),
        const Expanded(child: Divider(thickness: 0.5)),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.facebook, Colors.blue.shade800),
        SizedBox(width: 20.w),
        _buildSocialButton(Icons.email, Colors.red.shade700),
        SizedBox(width: 20.w),
        _buildSocialButton(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
        ],
      ),
      child: Icon(icon, color: color, size: 24.sp),
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("لديك حساب بالفعل؟ ",
            style: Theme.of(context).textTheme.bodyMedium),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
