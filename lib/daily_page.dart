import 'dart:ui';

import 'package:flutter/material.dart';
import 'detaildaily_page.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  final List<Map<String, dynamic>> days = const [
    {'title': 'Sam 15 Novembre', 'date': 'Grand départ', 'city': 'Départ', 'color': 0xFF6366F1},
    {'title': 'Dim 16 Novembre', 'date': 'Arrivée à Tokyo', 'city': 'Tokyo', 'color': 0xFFE53E3E},
    {'title': 'Lun 17 Novembre', 'date': 'Tokyo J2', 'city': 'Tokyo', 'color': 0xFFE53E3E},
    {'title': 'Mar 18 Novembre', 'date': 'Tokyo J3', 'city': 'Tokyo', 'color': 0xFFE53E3E},
    {'title': 'Mer 19 Novembre', 'date': 'DisneySea', 'city': 'Tokyo', 'color': 0xFFE53E3E},
    {'title': 'Jeu 20 Novembre', 'date': 'Ville de Kamakura', 'city': 'Kamakura', 'color': 0xFF10B981},
    {'title': 'Ven 21 Novembre', 'date': 'Lac Yamanaka et Mont Fuji', 'city': 'Fuji', 'color': 0xFF8B5CF6},
    {'title': 'Sam 22 Novembre', 'date': 'Hakone', 'city': 'Hakone', 'color': 0xFF06B6D4},
    {
      'title': 'Dim 23 Novembre',
      'date': 'Retour à Tokyo pour un dimanche détente',
      'city': 'Tokyo',
      'color': 0xFFEF4444,
    },
    {'title': 'Lun 24 Novembre', 'date': 'Osaka J1', 'city': 'Osaka', 'color': 0xFFED64A6},
    {'title': 'Mar 25 Novembre', 'date': 'Osaka J2 Universal Studio', 'city': 'Osaka', 'color': 0xFFED64A6},
    {'title': 'Mer 26 Novembre', 'date': 'Osaka J3 repos', 'city': 'Osaka', 'color': 0xFFED64A6},
    {'title': 'Jeu 27 Novembre', 'date': 'Nara et retour Osaka', 'city': 'Nara', 'color': 0xFF38A169},
    {'title': 'Ven 28 Novembre', 'date': 'Kyoto J1, Quartier Est, Higashiyama', 'city': 'Kyoto', 'color': 0xFFD69E2E},
    {'title': 'Sam 29 Novembre', 'date': 'Kyoto J2, Quartier Ouest', 'city': 'Kyoto', 'color': 0xFFD69E2E},
    {'title': 'Dim 30 Novembre', 'date': 'Kyoto J3, Quartier Sud', 'city': 'Kyoto', 'color': 0xFFD69E2E},
    {'title': 'Lun 1 Décembre', 'date': 'Kyoto J4, Quartier Nord', 'city': 'Kyoto', 'color': 0xFFD69E2E},
    {'title': 'Mar 2 Décembre', 'date': 'Ishigaki J1 : Kabira Bay', 'city': 'Ishigaki', 'color': 0xFF14B8A6},
    {
      'title': 'Mer 3 Décembre',
      'date': 'Ishigaki J2 : Yaima Village et Yonehara Beach',
      'city': 'Ishigaki',
      'color': 0xFF14B8A6,
    },
    {'title': 'Jeu 4 Décembre', 'date': 'Ishigaki J3 : île d\'Iriomote', 'city': 'Ishigaki', 'color': 0xFF14B8A6},
    {'title': 'Ven 5 Décembre', 'date': 'Ishigaki J4 et retour à Tokyo', 'city': 'Tokyo', 'color': 0xFFEF4444},
    {'title': 'Sam 6 Décembre', 'date': 'Retour en France', 'city': 'Retour', 'color': 0xFF6366F1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFE9ECEF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Journal de Bord',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${days.length} jours d\'aventure au Japon',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Timeline List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final color = Color(day['color'] as int);
                    final isLast = index == days.length - 1;
                    
                    return _buildTimelineItem(
                      context,
                      day: day,
                      index: index,
                      color: color,
                      isLast: isLast,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required Map<String, dynamic> day,
    required int index,
    required Color color,
    required bool isLast,
  }) {
    String imagePath = 'assets/cards/${index + 1}.png';
    
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DayEditorPage(day: index + 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Timeline indicator
              Container(
                width: 60,
                height: 120,
                child: Column(
                  children: [
                    // Day circle
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // Timeline line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Container(
                  height: 120,
                  child: Row(
                    children: [
                      // Image
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.image,
                                  color: color,
                                  size: 32,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      
                      // Text content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // City badge
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  day['city'] ?? '',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              
                              // Date
                              Text(
                                day['title'] ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 4),
                              
                              // Activity
                              Text(
                                day['date'] ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Arrow
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
