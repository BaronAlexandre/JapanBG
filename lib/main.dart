import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'home_page.dart';
import 'maps_page.dart';
import 'convert_page.dart';
import 'daily_page.dart';
import 'communicate_page.dart';
import 'theme.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const NavigationBarApp());
}

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japan Travel App',
      debugShowCheckedModeBanner: false,
      theme: JapanTheme.buildTheme(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const DailyPage(),
    const ConvertPage(),
    const CommunicatePage(),
    const MapsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: JapanTheme.primaryRed,
        backgroundColor: Colors.black,
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 60,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: currentPageIndex == 0 ? Colors.white : Colors.white70,
            ),
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            label: 'Accueil',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.calendar_month_rounded,
              color: currentPageIndex == 1 ? Colors.white : Colors.white70,
            ),
            icon: Icon(Icons.calendar_month_outlined, color: Colors.white70),
            label: 'Journal Bord',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.change_circle_rounded,
              color: currentPageIndex == 2 ? Colors.white : Colors.white70,
            ),
            icon: Icon(Icons.change_circle_outlined, color: Colors.white70),
            label: 'Convertisseur',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.emoji_people,
              color: currentPageIndex == 3 ? Colors.white : Colors.white70,
            ),
            icon: Icon(Icons.emoji_people_outlined, color: Colors.white70),
            label: 'Communiquer',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.map_outlined,
              color: currentPageIndex == 4 ? Colors.white : Colors.white70,
            ),
            icon: Icon(Icons.map_outlined, color: Colors.white70),
            label: 'Maps',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
