import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'home_screen.dart';
import '../requests/my_requests_screen.dart';
import '../favorites/favorites_screen.dart';
import '../profile/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  // قائمة الصفحات (حالياً عملنا الرئيسية بس، والباقي مؤقت)
  final List<Widget> _screens = [
    const HomeScreen(),          // الرئيسية
    const FavoritesScreen(),     // المفضلة
    const MyRequestsScreen(),    // طلباتي
    const Center(child: Text("استكشف (قريباً)")), // يمكن تركها كبحث متقدم لاحقاً
    const ProfileScreen(),       // حسابي
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // عشان الأيقونات متتحركش
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'طلباتي'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'استكشف'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}
