import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_page.dart';
import 'scan_page.dart';
import 'history_page.dart';
import 'locations_page.dart';

final GlobalKey<_MainPageState> mainPageKey = GlobalKey<_MainPageState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IDRenewApp());
}

class IDRenewApp extends StatelessWidget {
  const IDRenewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDRenew',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        primaryColor: const Color(0xFF10B981),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(key: mainPageKey),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    ScanPage(),
    HistoryPage(),
    LocationsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF10B981),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Locations"),
        ],
      ),
    );
  }
}
