import 'package:flutter/material.dart';
import 'home_page.dart';
import 'maps_page.dart';
import 'convert_page.dart';
import 'daily_page.dart';
import 'communicate_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('fr_FR', null);
  runApp(const NavigationBarApp());
}

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
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
        indicatorColor: const Color.fromARGB(255, 188, 0, 45),
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: currentPageIndex == 0 ? Colors.white : Colors.black38,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.calendar_month_rounded,
              color: currentPageIndex == 1 ? Colors.white : Colors.black38,
            ),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Journal Bord',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.change_circle_rounded,
              color: currentPageIndex == 2 ? Colors.white : Colors.black38,
            ),
            icon: Icon(Icons.change_circle_outlined),
            label: 'Convertisseur',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.emoji_people,
              color: currentPageIndex == 3 ? Colors.white : Colors.black38,
            ),
            icon: Icon(Icons.emoji_people_outlined),
            label: 'Communiquer',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.map,
              color: currentPageIndex == 4 ? Colors.white : Colors.black38,
            ),
            icon: Icon(Icons.map_outlined),
            label: 'Maps',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
