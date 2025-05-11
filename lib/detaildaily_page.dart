import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DayEditorPage extends StatefulWidget {
  final int day;
  const DayEditorPage({super.key, required this.day});

  @override
  State<DayEditorPage> createState() => _DayEditorPageState();
}

class _DayEditorPageState extends State<DayEditorPage> {
  late QuillController _controller;
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

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
          "Escale à Shanghaï à 7h pendant 2h10. Avion à 9h10\n\nArrivée à Narita International Airport (NRT) le 16 à 12h50\n\n1h de train pour rejoindre le centre ville de Tokyo\n\nRécupération du Airbnb\n\nTokyo J1, après-midi + soir, repos du voyage, premiers pas",
    },
    3: {
      "title": "Tokyo J2",
      "date": "Lun 17 Novembre",
      "text":
          "Temple Asakusa de bon matin pour éviter les touristes\n\nParc Ueno\n\nSanctuaire de Nezu-Jinja\n\nQuartier et cimetière de Yanaka\n\nAmeyoko street\n\nAkihabara",
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
          "Rando ou Vélo autour du lac avec vue sur le Mont Fuji\n\nVillage d'Oshino Hakkai\n\nPossibilité d'aller à Fujiyoshida voir la pagode à l'Arakurayama Senken Park (plus touristique)",
    },
    8: {
      "title": "Hakone",
      "date": "Sam 22 Novembre",
      "text":
          "Départ pour Hakone\n\nVisite du Hakone Shrine\n\nBalade autour du lac Ashi\n\nDétente dans un onsen (source chaude)",
    },
    9: {
      "title": "Retour à Tokyo pour un dimanche détente",
      "date": "Dim 23 Novembre",
      "text":
          "Musée ??\n\nAprès-midi : Shopping à Harajuku et visite du Meiji Jingu\n\nDîner à Shibuya\n\nPréparatifs pour Osaka le lendemain",
    },
    10: {
      "title": "Osaka J1",
      "date": "Lun 24 Novembre",
      "text":
          "Train pour Osaka (2h30 en Shinkansen)\n\nArrivée au Airbnb/Hotel, installation\n\nShinsekai\n\nDotonbori",
    },
    11: {
      "title": "Osaka J2 Universal Studio",
      "date": "Mar 25 Novembre",
      "text": "Universal Studio Japan",
    },
    12: {
      "title": "Osaka J3 repos",
      "date": "Mer 26 Novembre",
      "text": "Solaniwa Onsen\n\nExpédition vers le temple Katsuo-Ji",
    },
    13: {
      "title": "Nara et retour Osaka",
      "date": "Jeu 27 Novembre",
      "text":
          "Les biches (oh oui)\n\n1 aller-retour depuis Osaka pour garder le même hôtel\n\nSanctuaire Todai-ji\n\nLe soir : Umeda pour le quartier miam",
    },
    14: {
      "title": "Kyoto J1, Quartier Est, Higashiyama",
      "date": "Ven 28 Novembre",
      "text":
          "Départ d'Osaka vers Kyoto avec valises, arrivée au Airbnb/Hotel\n\nVisite de Gion",
    },
    15: {
      "title": "Kyoto J2, Quartier Ouest",
      "date": "Sam 29 Novembre",
      "text":
          "Kinkaku-ji le matin pour éviter l'afflux de touristes\n\nArashiyama\n\nPont Togetsukyo",
    },
    16: {
      "title": "Kyoto J3, Quartier Sud",
      "date": "Dim 30 Novembre",
      "text": "Fushimi Inari-Taisha\n\nUji, ville du thé",
    },
    17: {
      "title": "Kyoto J4, Quartier Nord",
      "date": "Lun 1 Décembre",
      "text":
          "Excursion de Kurama Dera vers le temple Kifune : randonnée de 2-3h\n\nRetour sur Kyoto l'après-midi, détente et Onsen\n\nRetour sur Osaka le soir, nuit sur place avant l'aéroport le lendemain",
    },
    18: {
      "title": "Ishigaki J1 : Kabira Bay",
      "date": "Mar 2 Décembre",
      "text":
          "Départ à 9h45 d'Osaka direction Ishigaki\n\nArrivée à 12h30 à Ishigaki\n\nDéjeuner dans le centre-ville + dépôt des bagages dans le Airbnb\n\n16h15: Bus 9 direction Kabira Bay\n\nMarche jusqu'à Hirari Island et/ou farniente à Tabaga Beach ou Sukuji Beach",
    },
    19: {
      "title": "Ishigaki J2 : Yaima Village et Yonehara Beach",
      "date": "Mer 3 Décembre",
      "text":
          "Ishigaki Yaima Village et Lone mangrove\n\nBus jusqu'au Jardin des sciences puis marche jusqu'à Crystal Beach\n\nMarche jusqu'au Jardin de Sculptures “des lions Shisa”\n\nSnorkeling à Yonehara Beach\n\nVisite Blue cave",
    },
    20: {
      "title": "Ishigaki J3 : île d'Iriomote",
      "date": "Jeu 4 Décembre",
      "text":
          "Départ en bateau vers Iriomote\n\nKayak dans la rivière de Mangrove (voir si visite guidée nécessaire)\n\nRandonnée et montée au point de vue de Pinasaira\n\nBaignade dans les chutes de Pinasaira\n\nRetour à Ishigaki",
    },
    21: {
      "title": "Ishigaki J4 et retour à Tokyo",
      "date": "Ven 5 Décembre",
      "text":
          "Montée du Mont Omoto ou Nosokodake\n\nOu excursion snorkeling à l'île Phantom\n\nDépart à 19h25 et arrivée à Tokyo à 22h30",
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
    _controller = QuillController.basic();
    _loadContent();
  }

  Future<void> _loadContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? content = prefs.getString('day_${widget.day}');

    if (content != null) {
      _controller = QuillController(
        document: Document.fromJson(jsonDecode(content)),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      String initialText = _dayInfo[widget.day]?['text'] ?? '';

      var initialJson = [
        {'insert': initialText},
        {'insert': '\n'},
      ];
      _controller = QuillController(
        document: Document.fromJson(initialJson),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    setState(() {});
  }

  Future<void> _saveContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String content = jsonEncode(_controller.document.toDelta().toJson());
    await prefs.setString('day_${widget.day}', content);
  }

  @override
  void dispose() {
    _saveContent();
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayData = _dayInfo[widget.day] ?? {};
    final title = dayData["title"] ?? "";
    final date = dayData["date"] ?? "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 200, 200),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            Text(date, style: const TextStyle(fontSize: 14)),
            Text('Jour ${widget.day}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
            onPressed: () async {
              bool? confirmReset = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                        'Êtes-vous sûr de vouloir réinitialiser ce jour ?',
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        ElevatedButton(
                          child: const Text('Confirmer'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
              );

              if (confirmReset == true) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('day_${widget.day}');
                _loadContent();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            QuillSimpleToolbar(
              controller: _controller,
              config: QuillSimpleToolbarConfig(
                embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                showClipboardPaste: true,
                customButtons: [
                  QuillToolbarCustomButtonOptions(
                    icon: const Icon(Icons.add_alarm_rounded),
                    onPressed: () {
                      _controller.document.insert(
                        _controller.selection.extentOffset,
                        TimeStampEmbed(DateTime.now().toString()),
                      );

                      _controller.updateSelection(
                        TextSelection.collapsed(
                          offset: _controller.selection.extentOffset + 1,
                        ),
                        ChangeSource.local,
                      );
                    },
                  ),
                ],
                buttonOptions: QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    afterButtonPressed: () {
                      final isDesktop = {
                        TargetPlatform.linux,
                        TargetPlatform.windows,
                        TargetPlatform.macOS,
                      }.contains(defaultTargetPlatform);
                      if (isDesktop) {
                        _editorFocusNode.requestFocus();
                      }
                    },
                  ),
                  linkStyle: QuillToolbarLinkStyleButtonOptions(
                    validateLink: (link) {
                      return true;
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: QuillEditor(
                focusNode: _editorFocusNode,
                scrollController: _editorScrollController,
                controller: _controller,
                config: QuillEditorConfig(
                  placeholder: 'Start writing your notes...',
                  padding: const EdgeInsets.all(16),
                  embedBuilders: [
                    ...FlutterQuillEmbeds.editorBuilders(
                      imageEmbedConfig: QuillEditorImageEmbedConfig(
                        imageProviderBuilder: (context, imageUrl) {
                          if (imageUrl.startsWith('assets/')) {
                            return AssetImage(imageUrl);
                          }
                          return null;
                        },
                      ),
                    ),
                    TimeStampEmbedBuilder(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (widget.day > 1)
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DayEditorPage(day: widget.day - 1),
                        ),
                      );
                    },
                  ),
                  Text('J${widget.day - 1}'),
                ],
              )
            else
              SizedBox(width: 60),

            if (widget.day < 22)
              Row(
                children: [
                  Text('J${widget.day + 1}'),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DayEditorPage(day: widget.day + 1),
                        ),
                      );
                    },
                  ),
                ],
              )
            else
              SizedBox(width: 60),
          ],
        ),
      ),
    );
  }
}

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(String value) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}
