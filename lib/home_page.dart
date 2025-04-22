import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _japanTime = '';
  String _franceTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(minutes: 1), (Timer t) => _updateTime());
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    if (!mounted) return;
    setState(() {
      _japanTime = _getFormattedTime('Japan');
      _franceTime = _getFormattedTime('France');
    });
  }

  String _getFormattedTime(String timeZone) {
    final now = DateTime.now().toUtc();
    final formatter = DateFormat.jm('fr_FR');
    final localTime = now.add(Duration(hours: _getTimeZoneOffset(timeZone)));
    return formatter.format(localTime);
  }

  int _getTimeZoneOffset(String timeZone) {
    switch (timeZone) {
      case 'Japan':
        return 9;
      case 'France':
      default:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Voyage au Japon 2025 ! 🎌',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/group.png',
                fit: BoxFit.cover,
                height: 500,
              ),
              const SizedBox(height: 20),
              Text(
                'Informations utiles',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'D\'autres textes',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🇯🇵',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _japanTime,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '🇫🇷',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _franceTime,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse('https://www.example.com'));
                },
                child: Text(
                  'Voir le Google doc',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
