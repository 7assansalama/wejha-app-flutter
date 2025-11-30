import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/phone_input_field.dart';
import '../../widgets/primary_button.dart';
import '../home/main_layout_screen.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _LoginAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              const _Header(),
              SizedBox(height: 32.h),
              const _LoginForm(),
              SizedBox(height: 24.h),
              const _SocialLoginDivider(),
              SizedBox(height: 24.h),
              const _SocialButtons(),
              SizedBox(height: 48.h),
              const _SignupRedirect(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Separated Widgets ---

class _LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LoginAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            "العربية",
            style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
          ),
        ),
      ),
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
          "مرحباً بعودتك!",
          style: textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "ادخل بياناتك لمتابعة رحلتك معنا",
          style:
              textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const PhoneInputField(),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: "كلمة المرور",
          obscureText: _isObscure,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () => setState(() => _isObscure = !_isObscure),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen()),
            );
          },
          child: Text(
            "نسيت كلمة السر؟",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        PrimaryButton(
          text: "تسجيل الدخول",
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
            );
          },
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
          child: Text(
            "أو الدخول بواسطة",
            style: Theme.of(context).textTheme.bodySmall,
          ),
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

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("ليس لديك حساب؟ ", style: Theme.of(context).textTheme.bodyMedium),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: Text(
            "أنشئ حساب",
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
