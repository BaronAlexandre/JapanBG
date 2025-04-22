import 'package:flutter/material.dart';
import 'home_page.dart';
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
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Journal Bord',
          ),
          NavigationDestination(
            icon: Icon(Icons.change_circle_rounded),
            label: 'Convertisseur',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_people),
            label: 'Communiquer',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
