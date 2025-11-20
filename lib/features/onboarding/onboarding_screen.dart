import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

// Data Model for type safety and clarity
class OnboardingPageData {
  final String image;
  final String title;
  final String description;

  const OnboardingPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      image: "assets/images/onboarding_1.png",
      title: "تعلُّم مُصمَّم من أجلك",
      description: "استعرض أفضل المؤسسات التعليمية والدورات المصممة خصيصاً لنموك الشخصي والمهني.",
    ),
    OnboardingPageData(
      image: "assets/images/onboarding_2.png",
      title: "خطوة واحدة للتسجيل",
      description: "وجدت الدورة المناسبة؟ قدّم طلبك مباشرة من خلال التطبيق بسهولة وبدون تعقيدات.",
    ),
    OnboardingPageData(
      image: "assets/images/onboarding_3.png",
      title: "رحلتك... على طريقتك",
      description: "احفظ مراكزك المفضلة، اقرأ تقييمات حقيقية، وتلقي إشعارات بكل جديد في مكان واحد.",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _isLastPage = index == _pages.length - 1);
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _OnboardingAppBar(onSkip: _navigateToLogin),
      body: _OnboardingPageView(
        controller: _pageController,
        pages: _pages,
        onPageChanged: _onPageChanged,
      ),
      bottomSheet: _OnboardingBottomSheet(
        isLastPage: _isLastPage,
        pageController: _pageController,
        pagesCount: _pages.length,
        onButtonPressed: () {
          if (_isLastPage) {
            _navigateToLogin();
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}

// Separated AppBar widget
class _OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkip;
  const _OnboardingAppBar({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: onSkip,
          child: Text(
            "تخطي",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Separated PageView widget
class _OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final List<OnboardingPageData> pages;
  final ValueChanged<int> onPageChanged;

  const _OnboardingPageView({required this.controller, required this.pages, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return _OnboardingPage(page: pages[index]);
      },
    );
  }
}

// Separated BottomSheet widget
class _OnboardingBottomSheet extends StatelessWidget {
  final bool isLastPage;
  final int pagesCount;
  final PageController pageController;
  final VoidCallback onButtonPressed;

  const _OnboardingBottomSheet({
    required this.isLastPage,
    required this.pagesCount,
    required this.pageController,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      height: 140.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: pagesCount,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.dotInactive,
              dotHeight: 8.h,
              dotWidth: 8.w,
              spacing: 8.w,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              child: Text(isLastPage ? "ابدأ رحلتك الآن" : "التالي"),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

// Widget for a single onboarding page
class _OnboardingPage extends StatelessWidget {
  final OnboardingPageData page;
  const _OnboardingPage({required this.page});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(page.image, height: 280.h, width: double.infinity, fit: BoxFit.contain),
        SizedBox(height: 40.h),
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            page.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
