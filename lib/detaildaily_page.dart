import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';

class DayEditorPage extends StatefulWidget {
  final int day;
  const DayEditorPage({super.key, required this.day});

  @override
  State<DayEditorPage> createState() => _DayEditorPageState();
}

class _DayEditorPageState extends State<DayEditorPage> with WidgetsBindingObserver {
  late QuillController _controller;
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();
  Timer? _saveTimer;

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
    WidgetsBinding.instance.addObserver(this);
    // Initial controller with default day content so UI is never blank
    _controller = _createDefaultController();
    // Asynchronously load any persisted content and replace controller safely
    _loadContent();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Sauvegarder quand l'app passe en arrière-plan ou se ferme
    if (state == AppLifecycleState.paused || 
        state == AppLifecycleState.detached) {
      _saveContent();
    }
  }

  Future<void> _loadContent() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? content = prefs.getString('day_${widget.day}');

      QuillController newController;
      if (content != null && content.isNotEmpty) {
        try {
          final jsonData = jsonDecode(content);
          newController = QuillController(
            document: Document.fromJson(jsonData),
            selection: const TextSelection.collapsed(offset: 0),
          );
        } catch (e) {
          // Parsing JSON failed; fallback to default content.
          newController = _createDefaultController();
        }
      } else {
        newController = _createDefaultController();
      }

      // Replace controller safely
      final oldController = _controller;
      oldController.removeListener(_autoSave);
      _controller = newController;
      _controller.addListener(_autoSave);
      oldController.dispose();

      // Loaded document; length: ${_controller.document.length}
      if (mounted) setState(() {});
    } catch (e) {
      // Erreur lors du chargement: $e
      // keep existing controller, ensure listener
      _controller.removeListener(_autoSave);
      _controller.addListener(_autoSave);
      if (mounted) setState(() {});
    }
  }

  QuillController _createDefaultController() {
    // Utiliser le contenu initial
    String initialText = _dayInfo[widget.day]?['text'] ?? '';

    if (initialText.isNotEmpty) {
      final delta = [
        {'insert': initialText + (initialText.endsWith('\n') ? '' : '\n')},
      ];
      return QuillController(
        document: Document.fromJson(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      final controller = QuillController.basic();
      if (controller.document.isEmpty()) {
        controller.document.insert(0, '\n');
      }
      return controller;
    }
  }

  Future<void> _saveContent() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String content = jsonEncode(_controller.document.toDelta().toJson());
      await prefs.setString('day_${widget.day}', content);
  // Saved content.
    } catch (e) {
  // Erreur lors de la sauvegarde: $e
    }
  }

  void _autoSave() {
    // Annuler le timer précédent s'il existe
    _saveTimer?.cancel();
    
    // Créer un nouveau timer pour sauvegarder après 2 secondes
    _saveTimer = Timer(const Duration(seconds: 2), () {
      _saveContent();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveTimer?.cancel();
    _controller.removeListener(_autoSave);
    // Fire and forget last save (can't await in dispose safely)
    _saveContent();
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  Color _getDayColor() {
    // Retourner les mêmes couleurs que dans daily_page.dart
    final colorMap = {
      1: Color(0xFF6366F1), // Départ
      2: JapanTheme.primaryRed, 3: JapanTheme.primaryRed, 4: JapanTheme.primaryRed, 5: JapanTheme.primaryRed, 9: JapanTheme.primaryRed, 21: JapanTheme.primaryRed, // Tokyo
      6: Color(0xFF10B981), // Kamakura
      7: Color(0xFF8B5CF6), // Fuji
      8: Color(0xFF06B6D4), // Hakone
      10: JapanTheme.sakuraPink, 11: JapanTheme.sakuraPink, 12: JapanTheme.sakuraPink, // Osaka
      13: JapanTheme.forestGreen, // Nara
      14: JapanTheme.secondaryGold, 15: JapanTheme.secondaryGold, 16: JapanTheme.secondaryGold, 17: JapanTheme.secondaryGold, // Kyoto
      18: Color(0xFF14B8A6), 19: Color(0xFF14B8A6), 20: Color(0xFF14B8A6), // Ishigaki
      22: Color(0xFF6366F1), // Retour
    };
    return colorMap[widget.day] ?? Color(0xFF6B7280);
  }

  String _getCityName() {
    final cityMap = {
      1: 'Départ', 22: 'Retour',
      2: 'Tokyo', 3: 'Tokyo', 4: 'Tokyo', 5: 'Tokyo', 9: 'Tokyo', 21: 'Tokyo',
      6: 'Kamakura', 7: 'Fuji', 8: 'Hakone',
      10: 'Osaka', 11: 'Osaka', 12: 'Osaka', 13: 'Nara',
      14: 'Kyoto', 15: 'Kyoto', 16: 'Kyoto', 17: 'Kyoto',
      18: 'Ishigaki', 19: 'Ishigaki', 20: 'Ishigaki',
    };
    return cityMap[widget.day] ?? 'Japon';
  }

  @override
  Widget build(BuildContext context) {
    final dayData = _dayInfo[widget.day] ?? {};
    final title = dayData["title"] ?? "";
    final date = dayData["date"] ?? "";
    final dayColor = _getDayColor();
    final cityName = _getCityName();
    
    // Le contrôleur est toujours disponible (initialisé vide puis chargé)
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              dayColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: dayColor),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: dayColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      cityName,
                                      style: TextStyle(
                                        color: dayColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: dayColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: dayColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${widget.day}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: dayColor),
                            onSelected: (value) async {
                              if (value == 'reset') {
                                bool? confirmReset = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(Icons.warning_amber, color: Colors.orange),
                                        SizedBox(width: 8),
                                        Text('Confirmation'),
                                      ],
                                    ),
                                    content: Text(
                                      'Êtes-vous sûr de vouloir réinitialiser ce jour ? Toutes vos modifications seront perdues.',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Annuler'),
                                        onPressed: () => Navigator.of(context).pop(false),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: Text('Réinitialiser'),
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
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'reset',
                                child: Row(
                                  children: [
                                    Icon(Icons.refresh, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Réinitialiser'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Toolbar avec design amélioré
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                child: QuillSimpleToolbar(
                  controller: _controller,
                  config: QuillSimpleToolbarConfig(
                    embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                    showClipboardPaste: true,
                    customButtons: [
                      QuillToolbarCustomButtonOptions(
                        icon: Icon(Icons.schedule, color: dayColor),
                        onPressed: () {
                          final now = DateTime.now();
                          final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
                          _controller.document.insert(
                            _controller.selection.extentOffset,
                            TimeStampEmbed(timeStr),
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
              ),
              
              SizedBox(height: 16),
              
              // Editor avec design amélioré
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Scrollbar(
                      controller: _editorScrollController,
                      thumbVisibility: true,
                      child: QuillEditor(
                        focusNode: _editorFocusNode,
                        scrollController: _editorScrollController,
                        controller: _controller,
                        config: QuillEditorConfig(
                        placeholder: 'Commencez à écrire vos notes du jour...',
                        padding: const EdgeInsets.all(20),
                        autoFocus: false,
                          expands: false,
                          scrollable: true,
                        showCursor: true,
                        paintCursorAboveText: false,
                        enableInteractiveSelection: true,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardAppearance: Brightness.light,
                        embedBuilders: [
                          ...FlutterQuillEmbeds.editorBuilders(
                            imageEmbedConfig: QuillEditorImageEmbedConfig(
                              imageProviderBuilder: (context, imageUrl) {
                                if (imageUrl.startsWith('assets/')) {
                                  return AssetImage(imageUrl);
                                }
                                return NetworkImage(imageUrl);
                              },
                            ),
                          ),
                          TimeStampEmbedBuilder(),
                        ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      
      // Navigation redesignée
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (widget.day > 1)
                _buildNavButton(
                  icon: Icons.arrow_back_ios,
                  label: 'J${widget.day - 1}',
                  onPressed: () {
                    _navigateToDay(widget.day - 1, backwards: true);
                  },
                  isNext: false,
                )
              else
                SizedBox(width: 80),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: dayColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Jour ${widget.day} / 22',
                  style: TextStyle(
                    color: dayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              if (widget.day < 22)
                _buildNavButton(
                  icon: Icons.arrow_forward_ios,
                  label: 'J${widget.day + 1}',
                  onPressed: () {
                    _navigateToDay(widget.day + 1, backwards: false);
                  },
                  isNext: true,
                )
              else
                SizedBox(width: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isNext,
  }) {
    final dayColor = _getDayColor();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: dayColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: isNext ? [
              Text(
                label,
                style: TextStyle(
                  color: dayColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4),
              Icon(icon, color: dayColor, size: 16),
            ] : [
              Icon(icon, color: dayColor, size: 16),
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: dayColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDay(int day, {required bool backwards}) {
    // Dispose current page after pushReplacement to free resources
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DayEditorPage(day: day),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final beginOffset = backwards ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
          final endOffset = Offset.zero;
          final tween = Tween(begin: beginOffset, end: endOffset).chain(CurveTween(curve: Curves.easeOutCubic));
          final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation.drive(opacityTween),
              child: child,
            ),
          );
        },
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, color: Colors.blue[600], size: 16),
          SizedBox(width: 6),
          Text(
            embedContext.node.value.data as String,
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
