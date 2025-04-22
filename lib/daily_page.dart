import 'dart:ui';

import 'package:flutter/material.dart';
import 'detaildaily_page.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  // Liste des jours avec leurs dates et titres
  final List<Map<String, String>> days = const [
    {'title': 'Sam 15 Novembre', 'date': 'Grand départ'},
    {'title': 'Dim 16 Novembre', 'date': 'Arrivée à Tokyo'},
    {'title': 'Lun 17 Novembre', 'date': 'Tokyo J2'},
    {'title': 'Mar 18 Novembre', 'date': 'Tokyo J3'},
    {'title': 'Mer 19 Novembre', 'date': 'DisneySea'},
    {'title': 'Jeu 20 Novembre', 'date': 'Ville de Kamakura'},
    {'title': 'Ven 21 Novembre', 'date': 'Lac Yamanaka et Mont Fuji'},
    {'title': 'Sam 22 Novembre', 'date': 'Hakone'},
    {'title': 'Dim 23 Novembre', 'date': 'Musée ??'},
    {'title': 'Lun 24 Novembre', 'date': '??'},
    {'title': 'Mar 25 Novembre', 'date': '??'},
    {'title': 'Mer 26 Novembre', 'date': 'Osaka J1'},
    {'title': 'Jeu 27 Novembre', 'date': 'Osaka J2 Universal Studio'},
    {'title': 'Ven 28 Novembre', 'date': 'Nara et Osaka'},
    {'title': 'Sam 29 Novembre', 'date': 'Kyoto J1'},
    {'title': 'Dim 30 Novembre', 'date': 'Kyoto J2'},
    {'title': 'Lun 1 Décembre', 'date': 'Kyoto J3'},
    {'title': 'Mar 2 Décembre', 'date': 'Ishigaki J1'},
    {'title': 'Mer 3 Décembre', 'date': 'Ishigaki J2'},
    {'title': 'Jeu 4 Décembre', 'date': 'Ishigaki J3'},
    {'title': 'Ven 5 Décembre', 'date': 'Ishigaki J4 et retour à Tokyo'},
    {'title': 'Sam 6 Décembre', 'date': 'Retour en France'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 7 jours par ligne
          childAspectRatio: 1.2, // Aspect ratio pour avoir un carré ou presque
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          String imagePath = 'assets/cards/${index + 1}.png';

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // Passer l'index + 1 pour désigner le jour sélectionné
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => DayEditorPage(
                          day: index + 1,
                        ), // Passer l'index + 1 pour le jour sélectionné
                  ),
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image de fond avec flou et transparence
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 1,
                      sigmaY: 1,
                    ), // Flou léger
                    child: Opacity(
                      opacity: 0.7, // Transparence de l'image
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ),

                  // Numéro en haut a gauche
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'J${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Contenu textuel sur fond blanc
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.9,
                        ), // Fond blanc légèrement transparent
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            day['date'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Texte foncé sur fond clair
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day['title'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
