import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screen/home_screen.dart';
import 'screen/stats_screen.dart';
import 'screen/profile_screen.dart';

// ═══════════════════════════════════════════════════════════════
// Entry point BangunYuk — bootstrap app + bottom navigation.
// Tidak ada logika alarm / storage / sensor di sini.
// ═══════════════════════════════════════════════════════════════

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const BangunYukApp());
}

class BangunYukApp extends StatelessWidget {
  const BangunYukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BangunYuk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}

/// Shell utama: Scaffold + Bottom Navigation untuk 3 tab.
/// Hanya mengatur perpindahan layar — tanpa logika bisnis.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    StatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        height: 70,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primarySoft,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.navActive),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon:
                Icon(Icons.bar_chart_rounded, color: AppColors.navActive),
            label: 'Statistik',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon:
                Icon(Icons.person_rounded, color: AppColors.navActive),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
