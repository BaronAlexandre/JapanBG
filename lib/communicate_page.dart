import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class Phrase {
  final String francais;
  final String japonais;
  final String romaji;
  final String emoji;

  Phrase({
    required this.francais,
    required this.japonais,
    required this.romaji,
    required this.emoji,
  });
}

final Map<String, List<Phrase>> phrasesParCategorie = {
  'Salutations et Politesse': [
    Phrase(
      francais: 'Bonjour (le matin)',
      japonais: 'おはようございます',
      romaji: 'Ohayou gozaimasu',
      emoji: '🌅',
    ),
    Phrase(
      francais: 'Bonjour (journée)',
      japonais: 'こんにちは',
      romaji: 'Konnichiwa',
      emoji: '☀️',
    ),
    Phrase(
      francais: 'Bonsoir',
      japonais: 'こんばんは',
      romaji: 'Konbanwa',
      emoji: '🌆',
    ),
    Phrase(
      francais: 'Au revoir',
      japonais: 'さようなら',
      romaji: 'Sayounara',
      emoji: '👋',
    ),
    Phrase(
      francais: 'Merci',
      japonais: 'ありがとうございます',
      romaji: 'Arigatou gozaimasu',
      emoji: '🙏',
    ),
    Phrase(
      francais: 'S\'il vous plaît',
      japonais: 'お願いします',
      romaji: 'Onegaishimasu',
      emoji: '🙇',
    ),
    Phrase(
      francais: 'Excusez-moi / Pardon',
      japonais: 'すみません',
      romaji: 'Sumimasen',
      emoji: '😅',
    ),
    Phrase(
      francais: 'De rien',
      japonais: 'どういたしまして',
      romaji: 'Dou itashimashite',
      emoji: '😊',
    ),
    Phrase(francais: 'Oui', japonais: 'はい', romaji: 'Hai', emoji: '👍'),
    Phrase(francais: 'Non', japonais: 'いいえ', romaji: 'Iie', emoji: '🙅'),
  ],

  'Se Présenter et Se Décrire': [
    Phrase(
      francais: 'Je m\'appelle...',
      japonais: 'わたしは...と言います',
      romaji: 'Watashi wa ... to iimasu',
      emoji: '🙋',
    ),
    Phrase(
      francais: 'Enchanté',
      japonais: 'はじめまして',
      romaji: 'Hajimemashite',
      emoji: '🤝',
    ),
    Phrase(
      francais: 'Je suis français(e)',
      japonais: 'フランス人です',
      romaji: 'Furansu-jin desu',
      emoji: '🇫🇷',
    ),
  ],

  'Orientation et Directions': [
    Phrase(
      francais: 'Où est ... ?',
      japonais: '...はどこですか？',
      romaji: '... wa doko desu ka?',
      emoji: '📍',
    ),
    Phrase(francais: 'La gare', japonais: '駅', romaji: 'Eki', emoji: '🚉'),
    Phrase(
      francais: 'Les toilettes',
      japonais: 'トイレ',
      romaji: 'Toire',
      emoji: '🚻',
    ),
    Phrase(
      francais: 'L\'hôtel',
      japonais: 'ホテル',
      romaji: 'Hoteru',
      emoji: '🏨',
    ),
    Phrase(
      francais: 'Ce train va à ... ?',
      japonais: 'この電車は...に行きますか ?',
      romaji: 'Kono densha wa ... ni ikimasu ka?',
      emoji: '🚆',
    ),
    Phrase(francais: 'À gauche', japonais: '左', romaji: 'Hidari', emoji: '⬅️'),
    Phrase(francais: 'À droite', japonais: '右', romaji: 'Migi', emoji: '➡️'),
    Phrase(
      francais: 'Tout droit',
      japonais: 'まっすぐ',
      romaji: 'Massugu',
      emoji: '⬆️',
    ),
  ],

'Restaurants et Repas': [
    Phrase(
      francais: 'Qu\'est-ce que vous conseillez ?',
      japonais: '何をおすすめしますか？',
      romaji: 'Nani o osusume shimasu ka?',
      emoji: '👨‍🍳',
    ),
    Phrase(
      francais: 'Quelle est la spécialité de la maison ?',
      japonais: 'お店の名物は何ですか？',
      romaji: 'Omise no meibutsu wa nan desu ka?',
      emoji: '⭐',
    ),
    Phrase(
      francais: 'Je voudrais des ramen, s\'il vous plaît',
      japonais: 'ラーメンをお願いします',
      romaji: 'Raamen o onegaishimasu',
      emoji: '🍜',
    ),
    Phrase(
      francais: 'Avez-vous des sushi frais ?',
      japonais: '新鮮な寿司はありますか？',
      romaji: 'Shinsen na sushi wa arimasu ka?',
      emoji: '🍣',
    ),
    Phrase(
      francais: 'Je voudrais essayer le plat local',
      japonais: '郷土料理を食べてみたいです',
      romaji: 'Kyoudo ryouri o tabete mitai desu',
      emoji: '🥢',
    ),
    Phrase(
      francais: 'Qu\'est-ce qu\'il y a dans ce plat ?',
      japonais: 'この料理には何が入っていますか？',
      romaji: 'Kono ryouri ni wa nani ga haitte imasu ka?',
      emoji: '🔍',
    ),
    Phrase(
      francais: 'C\'est épicé ?',
      japonais: '辛いですか？',
      romaji: 'Karai desu ka?',
      emoji: '🌶️',
    ),
    Phrase(
      francais: 'Une portion pour une personne',
      japonais: '一人前をお願いします',
      romaji: 'Hitorimae o onegaishimasu',
      emoji: '👤',
    ),
    Phrase(
      francais: 'L\'addition, s\'il vous plaît',
      japonais: 'お会計をお願いします',
      romaji: 'Okaikei o onegaishimasu',
      emoji: '💳',
    ),
    Phrase(
      francais: 'Où puis-je manger du bon yakitori ?',
      japonais: '美味しい焼き鳥はどこで食べられますか？',
      romaji: 'Oishii yakitori wa doko de taberaremasu ka?',
      emoji: '🍡',
    ),
    Phrase(
      francais: 'Y a-t-il un restaurant 24h/24 près d\'ici ?',
      japonais: '近くに24時間営業のレストランはありますか ?',
      romaji: 'Chikaku ni nijuuyojikan eigyou no resutoran wa arimasu ka?',
      emoji: '🌙',
    ),
    Phrase(
      francais: 'Je suis végétarien',
      japonais: 'ベジタリアンです',
      romaji: 'Bejitarian desu',
      emoji: '🥬',
    ),
    Phrase(
      francais: 'Pouvez-vous me montrer comment manger ceci ?',
      japonais: 'これをどうやって食べるか教えてください',
      romaji: 'Kore o dou yatte taberu ka oshiete kudasai',
      emoji: '🤔',
    ),
    Phrase(
      francais: 'C\'était absolument délicieux !',
      japonais: 'とても美味しかったです！',
      romaji: 'Totemo oishikatta desu!',
      emoji: '😋',
    ),
    Phrase(
      francais: 'Où est le meilleur restaurant de la ville ?',
      japonais: 'この街で一番美味しいレストランはどこですか？',
      romaji: 'Kono machi de ichiban oishii resutoran wa doko desu ka?',
      emoji: '🏆',
    ),
  ],

  'Shopping et Argent': [
    Phrase(
      francais: 'Y a-t-il un distributeur de billets près d\'ici ?',
      japonais: '近くにATMはありますか ?',
      romaji: 'Chikaku ni ATM wa arimasu ka?',
      emoji: '💳',
    ),
    Phrase(
      francais: 'Combien ça coûte ?',
      japonais: 'いくらですか？',
      romaji: 'Ikura desu ka?',
      emoji: '💰',
    ),
    Phrase(
      francais: 'Trop cher',
      japonais: '高すぎます',
      romaji: 'Taka sugimasu',
      emoji: '💸',
    ),
    Phrase(
      francais: 'Je veux acheter ça',
      japonais: 'これを買いたいです',
      romaji: 'Kore o kaitai desu',
      emoji: '🛍️',
    ),
    Phrase(
      francais: 'Avez-vous la taille M ?',
      japonais: 'Mサイズはありますか ?',
      romaji: 'M saizu wa arimasu ka?',
      emoji: '📏',
    ),
  ],

  'Transport et Déplacements': [
    Phrase(
      francais: 'À quelle heure part le dernier train ?',
      japonais: '最終電車は何時ですか ?',
      romaji: 'Saishuu densha wa nanji desu ka?',
      emoji: '⏰',
    ),
    Phrase(
      francais: 'Je veux aller à l\'aéroport',
      japonais: '空港に行きたいです',
      romaji: 'Kuukou ni ikitai desu',
      emoji: '✈️',
    ),
  ],

  'Loisirs et Visites Culturelles': [
    Phrase(
      francais: 'Pouvez-vous me recommander un musée ?',
      japonais: 'おすすめの博物館はありますか ?',
      romaji: 'Osusume no hakubutsukan wa arimasu ka?',
      emoji: '🖼️',
    ),
    Phrase(
      francais: 'Où est le temple le plus proche ?',
      japonais: '一番近い寺はどこですか ?',
      romaji: 'Ichiban chikai tera wa doko desu ka?',
      emoji: '⛩️',
    ),
    Phrase(
      francais:
          'Quel est le meilleur endroit pour voir des cerisiers en fleurs ?',
      japonais: '桜を見るのに一番いい場所はどこですか ?',
      romaji: 'Sakura o miru no ni ichiban ii basho wa doko desu ka?',
      emoji: '🌸',
    ),
    Phrase(
      francais: 'Y a-t-il un tampon du lieu ?',
      japonais: 'この場所のスタンプはありますか ?',
      romaji: 'Kono basho no sutanpu wa arimasu ka?',
      emoji: '🖋️',
    ),
  ],

  'Langue et Communication': [
    Phrase(
      francais: 'Parlez-vous anglais ?',
      japonais: '英語を話せますか ?',
      romaji: 'Eigo o hanasemasu ka?',
      emoji: '🇬🇧',
    ),
    Phrase(
      francais: 'Je ne parle pas bien japonais',
      japonais: '日本語が上手ではありません',
      romaji: 'Nihongo ga jouzu de wa arimasen',
      emoji: '😅',
    ),
  ],

  'Nombre': [
    Phrase(francais: 'zéro 0', japonais: 'ゼロ', romaji: 'Zero', emoji: '0️⃣'),
    Phrase(francais: 'un 1', japonais: '一', romaji: 'Ichi', emoji: '1️⃣'),
    Phrase(francais: 'deux 2', japonais: '二', romaji: 'Ni', emoji: '2️⃣'),
    Phrase(francais: 'trois 3', japonais: '三', romaji: 'San', emoji: '3️⃣'),
    Phrase(francais: 'quatre 4', japonais: '四', romaji: 'Yon', emoji: '4️⃣'),
    Phrase(francais: 'cinq 5', japonais: '五', romaji: 'Go', emoji: '5️⃣'),
    Phrase(francais: 'six 6', japonais: '六', romaji: 'Roku', emoji: '6️⃣'),
    Phrase(francais: 'sept 7', japonais: '七', romaji: 'Nana', emoji: '7️⃣'),
    Phrase(francais: 'huit 8', japonais: '八', romaji: 'Hachi', emoji: '8️⃣'),
    Phrase(francais: 'neuf 9', japonais: '九', romaji: 'Kyuu', emoji: '9️⃣'),
    Phrase(francais: 'dix 10', japonais: '十', romaji: 'Juu', emoji: '🔟'),
    Phrase(francais: 'cent 100', japonais: '百', romaji: 'Hyaku', emoji: '💯'),
    Phrase(francais: 'mille 1000', japonais: '千', romaji: 'Sen', emoji: '🔢'),
    Phrase(
      francais: 'dix mille',
      japonais: '一万',
      romaji: 'Ichiman',
      emoji: '🔟➕',
    ),
  ],
  'Mots Utiles': [
    Phrase(francais: 'Argent', japonais: 'お金', romaji: 'Okane', emoji: '💴'),
    Phrase(francais: 'Temple', japonais: '寺', romaji: 'Tera', emoji: '⛩️'),
    Phrase(francais: 'Où', japonais: 'どこ', romaji: 'Doko', emoji: '❓'),
    Phrase(
      francais: 'Ticket / Billet',
      japonais: '切符',
      romaji: 'Kippu',
      emoji: '🎫',
    ),
    Phrase(
      francais: 'Entrée',
      japonais: '入口',
      romaji: 'Iriguichi',
      emoji: '🚪',
    ),
    Phrase(francais: 'Sortie', japonais: '出口', romaji: 'Deguchi', emoji: '🚪'),
    Phrase(francais: 'Police', japonais: '警察', romaji: 'Keisatsu', emoji: '👮'),
    Phrase(francais: 'Hôpital', japonais: '病院', romaji: 'Byouin', emoji: '🏥'),
    Phrase(francais: 'Urgence', japonais: '緊急', romaji: 'Kinkyuu', emoji: '🚨'),
    Phrase(francais: 'Rue', japonais: '道', romaji: 'Michi', emoji: '🛣️'),
    Phrase(francais: 'Carte', japonais: '地図', romaji: 'Chizu', emoji: '🗺️'),
    Phrase(francais: 'Taxi', japonais: 'タクシー', romaji: 'Takushii', emoji: '🚕'),
    Phrase(
      francais: 'Station de métro',
      japonais: '地下鉄の駅',
      romaji: 'Chikatetsu no eki',
      emoji: '🚇',
    ),
  ],
};

class CommunicatePage extends StatefulWidget {
  const CommunicatePage({super.key});

  @override
  CommunicatePageState createState() => CommunicatePageState();
}

class CommunicatePageState extends State<CommunicatePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _translatorFocusNode = FocusNode();
  String _translatedText = '';
  final OnDeviceTranslator _translator = OnDeviceTranslator(
    sourceLanguage: TranslateLanguage.french,
    targetLanguage: TranslateLanguage.japanese,
  );

  @override
  void initState() {
    super.initState();
    _downloadModels();
  }

  Future<void> _downloadModels() async {
    final modelManager = OnDeviceTranslatorModelManager();
    await modelManager.downloadModel(TranslateLanguage.french.bcpCode);
    await modelManager.downloadModel(TranslateLanguage.japanese.bcpCode);
  }

  Future<void> _translateText() async {
    final result = await _translator.translateText(_textEditingController.text);
    setState(() {
      _translatedText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Dismiss keyboard when tapping outside translator input
          FocusScope.of(context).unfocus();
        },
  child: Container(
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
            children: [
              // Header moderne
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text('🇯🇵', style: TextStyle(fontSize: 24)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Blabla',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                'Phrases essentielles en japonais',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
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
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search, color: Colors.blue[600]),
                            onPressed: () {
                              showSearch(context: context, delegate: PhraseSearchDelegate());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Section traducteur
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.translate, color: Colors.green[600], size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Traducteur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          controller: _textEditingController,
                          focusNode: _translatorFocusNode,
                          maxLines: 2,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            hintText: 'Tapez votre texte en français...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            suffixIcon: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green[600],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.translate, color: Colors.white),
                                onPressed: _translateText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_translatedText.isNotEmpty) ...[
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Traduction :',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              SelectableText(
                                _translatedText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Liste des catégories
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: phrasesParCategorie.entries.length,
                  itemBuilder: (context, index) {
                    final entry = phrasesParCategorie.entries.elementAt(index);
                    return _buildCategoryCard(entry.key, entry.value);
                  },
                ),
              ),
            ],
          ),
        ), // end SafeArea
      ), // end gradient Container
    ), // end GestureDetector
  );
  }

  Widget _buildCategoryCard(String categoryName, List<Phrase> phrases) {
    final categoryColors = {
      'Salutations et Politesse': Colors.blue,
      'Se Présenter et Se Décrire': Colors.purple,
      'Orientation et Directions': Colors.orange,
      'Restaurants et Repas': Colors.red,
      'Shopping et Argent': Colors.green,
      'Transport et Déplacements': Colors.cyan,
      'Loisirs et Visites Culturelles': Colors.pink,
      'Langue et Communication': Colors.indigo,
      'Nombre': Colors.teal,
      'Mots Utiles': Colors.amber,
    };
    
    final color = categoryColors[categoryName] ?? Colors.grey;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(20),
          childrenPadding: EdgeInsets.only(bottom: 16),
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(categoryName),
              color: color,
              size: 20,
            ),
          ),
          title: Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          subtitle: Text(
            '${phrases.length} phrases',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          children: phrases.map((phrase) => _buildPhraseCard(phrase, color)).toList(),
        ),
      ),
    );
  }

  Widget _buildPhraseCard(Phrase phrase, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(phrase.emoji, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phrase.francais,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  phrase.japonais,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  phrase.romaji,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Salutations et Politesse': return Icons.waving_hand;
      case 'Se Présenter et Se Décrire': return Icons.person;
      case 'Orientation et Directions': return Icons.directions;
      case 'Restaurants et Repas': return Icons.restaurant;
      case 'Shopping et Argent': return Icons.shopping_bag;
      case 'Transport et Déplacements': return Icons.train;
      case 'Loisirs et Visites Culturelles': return Icons.museum;
      case 'Langue et Communication': return Icons.chat;
      case 'Nombre': return Icons.numbers;
      case 'Mots Utiles': return Icons.bookmark;
      default: return Icons.category;
    }
  }
}

class PhraseSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        phrasesParCategorie.entries
            .map((entry) {
              final filteredList =
                  entry.value.where((phrase) {
                    return phrase.francais.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                        phrase.japonais.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                        phrase.romaji.toLowerCase().contains(
                          query.toLowerCase(),
                        );
                  }).toList();

              return MapEntry(entry.key, filteredList);
            })
            .where((entry) => entry.value.isNotEmpty)
            .toList();

    return ListView(
      children:
          results.expand((entry) {
            return entry.value.map((phrase) {
              return ListTile(
                leading: Text(
                  phrase.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(phrase.francais),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phrase.japonais,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        phrase.romaji,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }).toList();
          }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        phrasesParCategorie.entries
            .map((entry) {
              final filteredList =
                  entry.value.where((phrase) {
                    return phrase.francais.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                        phrase.japonais.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                        phrase.romaji.toLowerCase().contains(
                          query.toLowerCase(),
                        );
                  }).toList();

              return MapEntry(entry.key, filteredList);
            })
            .where((entry) => entry.value.isNotEmpty)
            .toList();

    return ListView(
      children:
          suggestions.expand((entry) {
            return entry.value.map((phrase) {
              return ListTile(
                leading: Text(
                  phrase.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(phrase.francais),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phrase.japonais,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        phrase.romaji,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }).toList();
          }).toList(),
    );
  }

  // Use default dispose from SearchDelegate
}
