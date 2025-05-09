import 'package:flutter/material.dart';

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
      japonais: 'この電車は...に行きますか？',
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
      francais: 'Le menu, s\'il vous plaît',
      japonais: 'メニューをお願いします',
      romaji: 'Menyuu o onegaishimasu',
      emoji: '📋',
    ),
    Phrase(
      francais: 'C\'est quoi ce plat ?',
      japonais: 'これは何ですか？',
      romaji: 'Kore wa nan desu ka?',
      emoji: '🍽️',
    ),
    Phrase(
      francais: 'Je suis allergique à ...',
      japonais: '...のアレルギーがあります',
      romaji: '... no arerugii ga arimasu',
      emoji: '⚠️',
    ),
    Phrase(
      francais: 'Sans viande, s\'il vous plaît',
      japonais: '肉なしでお願いします',
      romaji: 'Niku nashi de onegaishimasu',
      emoji: '🥦',
    ),
    Phrase(
      francais: 'C\'était délicieux',
      japonais: 'おいしかったです',
      romaji: 'Oishikatta desu',
      emoji: '😋',
    ),
  ],

  'Shopping et Argent': [
    Phrase(
      francais: 'Y a-t-il un distributeur de billets près d\'ici ?',
      japonais: '近くにATMはありますか？',
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
      japonais: 'Mサイズはありますか？',
      romaji: 'M saizu wa arimasu ka?',
      emoji: '📏',
    ),
  ],

  'Transport et Déplacements': [
    Phrase(
      francais: 'À quelle heure part le dernier train ?',
      japonais: '最終電車は何時ですか？',
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
      japonais: 'おすすめの博物館はありますか？',
      romaji: 'Osusume no hakubutsukan wa arimasu ka?',
      emoji: '🖼️',
    ),
    Phrase(
      francais: 'Où est le temple le plus proche ?',
      japonais: '一番近い寺はどこですか？',
      romaji: 'Ichiban chikai tera wa doko desu ka?',
      emoji: '⛩️',
    ),
    Phrase(
      francais:
          'Quel est le meilleur endroit pour voir des cerisiers en fleurs ?',
      japonais: '桜を見るのに一番いい場所はどこですか？',
      romaji: 'Sakura o miru no ni ichiban ii basho wa doko desu ka?',
      emoji: '🌸',
    ),
    Phrase(
      francais: 'Y a-t-il un tampon du lieu ?',
      japonais: 'この場所のスタンプはありますか？',
      romaji: 'Kono basho no sutanpu wa arimasu ka?',
      emoji: '🖋️',
    ),
  ],

  'Langue et Communication': [
    Phrase(
      francais: 'Parlez-vous anglais ?',
      japonais: '英語を話せますか？',
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
  final String _searchQuery = '';
  final bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredPhrases =
        phrasesParCategorie.entries
            .map((entry) {
              final filteredList =
                  entry.value.where((phrase) {
                    return phrase.francais.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ||
                        phrase.japonais.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ||
                        phrase.romaji.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        );
                  }).toList();

              return MapEntry(entry.key, filteredList);
            })
            .where((entry) => entry.value.isNotEmpty)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pour blablater'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: PhraseSearchDelegate());
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _isSearching
                    ? ListView(
                      children:
                          filteredPhrases.expand((entry) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        phrase.japonais,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        phrase.romaji,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList();
                          }).toList(),
                    )
                    : ListView(
                      children:
                          phrasesParCategorie.entries.map((entry) {
                            return ExpansionTile(
                              title: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              children:
                                  entry.value.map((phrase) {
                                    return ListTile(
                                      leading: Text(
                                        phrase.emoji,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      title: Text(phrase.francais),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              phrase.japonais,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              phrase.romaji,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            );
                          }).toList(),
                    ),
          ),
        ],
      ),
    );
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
}
