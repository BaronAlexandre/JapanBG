import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DayEditorPage extends StatefulWidget {
  final int day;
  const DayEditorPage({super.key, required this.day});

  @override
  State<DayEditorPage> createState() => _DayEditorPageState();
}

class _DayEditorPageState extends State<DayEditorPage> {
  late TextEditingController _controller;

  final Map<int, Map<String, String>> _dayInfo = {
    1: {
      "title": "Grand départ",
      "date": "Sam 15 Novembre",
      "text": "Avion CDG le 15 novembre 2025 à 12h25, 11h35 de vol",
    },
    2: {
      "title": "Arrivée à Tokyo",
      "date": "Dim 16 Novembre",
      "text":
          "Escale à Shanghaï à 7h pendant 2h10. Avion à 9h10\n\nArrivée à Narita International Airport (NRT) le 16 à 12h50\n\n1h de train pour rejoindre le centre ville de Tokyo\n\nRécupération du Airbnb\n\nTokyo J1, après midi + soir, repos du voyage, premiers pas",
    },
    3: {
      "title": "Tokyo J2",
      "date": "Lun 17 Novembre",
      "text":
          "Temple Asakusa de bon matin pour éviter les touristes\n\nParc Ueno\n\nSanctuaire de Nezu-Junja\n\nQuartier et cimetière de Yanaka\n\nAmeyoko street\n\nAkihabara",
    },
    4: {
      "title": "Tokyo J3",
      "date": "Mar 18 Novembre",
      "text": "Matin : Temple Meiji Jingu\n\nShibuya\n\nShinjuku de nuit",
    },
    5: {
      "title": "DisneySea",
      "date": "Mer 19 Novembre",
      "text": "Détail par zone",
    },
    6: {
      "title": "Ville de Kamakura",
      "date": "Jeu 20 Novembre",
      "text":
          "S'arrêter à la gare Kita Kamakura\n\nVisite du temple Engaku-ji\n\nTemple Kencho-ji\n\nSanctuaire Tsurugaoka Hachiman-gu\n\nJardin de Bambou Hokoku-Ji\n\nGrand Bouddha de Kotoku-in\n\nTemple Hase-Dera\n\nSi encore du temps, aller à la plage (Kamakura est au bord de l'eau)",
    },
    7: {
      "title": "Lac Yamanaka et Mont Fuji",
      "date": "Ven 21 Novembre",
      "text":
          "Rando ou Vélo autour du lac avec vue sur le Mont Fuji\n\nVillage d'Oshino Hakkai\n\nSi le temps, possibilité d'aller à Fujiyoshida et voir la pagode à l'Arakurayama Senken Park (plus touristique)",
    },
    8: {
      "title": "Départ pour Hakone",
      "date": "Sam 22 Novembre",
      "text":
          "Visite du Hakone Shrine\n\nBalade autour du lac Ashi\n\nDétente dans un onsen (source chaude)",
    },
    9: {
      "title": "Musée ??",
      "date": "Dim 23 Novembre",
      "text":
          "Après-midi : Shopping à Harajuku et visite du Meiji Jingu.\n\nDîner à Shibuya.",
    },
    10: {
      "title": "Libre ou activité surprise",
      "date": "Lun 24 Novembre",
      "text": "",
    },
    11: {
      "title": "Libre ou activité surprise",
      "date": "Mar 25 Novembre",
      "text": "",
    },
    12: {
      "title": "Osaka J1",
      "date": "Mer 26 Novembre",
      "text": "Avion Seoul Osaka\n\nDotonbori",
    },
    13: {
      "title": "Universal Studio",
      "date": "Jeu 27 Novembre",
      "text": "Universal Studio Japan",
    },
    14: {
      "title": "Nara et retour Osaka",
      "date": "Ven 28 Novembre",
      "text":
          "Les biches (oh oui)\n\n1 aller-retour depuis Osaka pour garder le même hôtel\n\nSanctuaire Todai-ji\n\nLe soir : Umeda pour le quartier miam ?",
    },
    15: {
      "title": "Kyoto J1, Quartiers Nord et Ouest",
      "date": "Sam 29 Novembre",
      "text":
          "Départ d'Osaka vers Kyoto avec valises\n\nArashiyama\n\nPont Togetsukyo\n\nKinkaku-ji\n\nRyoan-ji",
    },
    16: {
      "title": "Kyoto J2, Quartiers Sud",
      "date": "Dim 30 Novembre",
      "text": "Fushimi Inari-Taisha\n\nUji, ville du thé",
    },
    17: {
      "title": "Kyoto J3, Quartiers Est",
      "date": "Lun 1 Décembre",
      "text": "Higashiyama\n\nGion",
    },
    18: {
      "title": "Ishigaki J1 : Kabira Bay",
      "date": "Mar 2 Décembre",
      "text":
          "Départ à 9h45 d'Osaka direction Ishigaki\n\nArrivée à 12h30 à Ishigaki\n\nDéjeuner dans le centre ville + dépôt des bagages dans le Airbnb\n\n16h15: Bus 9 direction Kabira Bay\n\nMarche jusqu'à Hirari Island et/ou farniente à Tabaga Beach ou Sukuji Beach",
    },
    19: {
      "title": "Ishigaki J2, Yaima Village et Yonehara",
      "date": "Mer 3 Décembre",
      "text":
          "Ishigaki Yaima Village et Lone mangrove\n\nBus jusqu'au Jardin des sciences puis marche jusqu'à Crystal Beach\n\nMarche jusqu'au Jardin de Sculptures “des lions Shisa”\n\nSnorkeling à Yonehara Beach\n\nVisite Blue cave",
    },
    20: {
      "title": "Ishigaki J3, île d'Iriomote",
      "date": "Jeu 4 Décembre",
      "text":
          "Départ en bateau vers Iriomote\n\nKayak dans la rivière de Mangrove (à confirmer : visite guidée ou non ?)\n\nRandonnée dans la jungle jusqu'au point de vue de Pinasaira\n\nBaignade dans les chutes d'eau de Pinasaira\n\nRetour à Ishigaki",
    },
    21: {
      "title": "Ishigaki J4 et retour à Tokyo",
      "date": "Ven 5 Décembre",
      "text":
          "Montée du Mont Omoto ou du Nosokodake\n\nOu excursion snorkeling à l'île Phantom\n\nDépart à 19h25 et arrivée à Tokyo à 22h30",
    },
    22: {
      "title": "Retour en France",
      "date": "Sam 6 Décembre",
      "text":
          "Avion Haneda Airport (HND) le 6 décembre à 8h40\n\nEscale à Shanghaï à 10h50 pour 1h35\n\nAvion à 12h25 puis arrivée à Paris à 18h05",
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedText();
  }

  Future<void> _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    final savedText =
        prefs.getString('day_${widget.day}_note') ??
        _dayInfo[widget.day]?["text"] ??
        "";
    setState(() {
      _controller.text = savedText;
    });
  }

  Future<void> _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('day_${widget.day}_note', _controller.text);
  }

  @override
  void dispose() {
    _saveText();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayData = _dayInfo[widget.day] ?? {};
    final title = dayData["title"] ?? "";
    final date = dayData["date"] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            Text(date, style: const TextStyle(fontSize: 14)),
            Text('Jour ${widget.day}', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          textAlign: TextAlign.start, // Alignement horizontal
          textAlignVertical:
              TextAlignVertical.top, // Alignement vertical en haut
          decoration: const InputDecoration(
            hintText: 'Écris ici ton texte pour ce jour...',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
