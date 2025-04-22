import 'package:flutter/material.dart';

// Modèle
class Phrase {
  final String francais;
  final String japonais;
  final String romaji;

  Phrase({
    required this.francais,
    required this.japonais,
    required this.romaji,
  });
}

final Map<String, List<Phrase>> phrasesParCategorie = {
  'Salutations & Politesse': [
    Phrase(francais: 'Bonjour (le matin)', japonais: 'おはようございます', romaji: 'Ohayou gozaimasu'),
    Phrase(francais: 'Bonjour (journée)', japonais: 'こんにちは', romaji: 'Konnichiwa'),
    Phrase(francais: 'Bonsoir', japonais: 'こんばんは', romaji: 'Konbanwa'),
    Phrase(francais: 'Au revoir', japonais: 'さようなら', romaji: 'Sayounara'),
    Phrase(francais: 'Merci', japonais: 'ありがとうございます', romaji: 'Arigatou gozaimasu'),
    Phrase(francais: 'S''il vous plaît', japonais: 'お願いします', romaji: 'Onegaishimasu'),
    Phrase(francais: 'Excusez-moi / Pardon', japonais: 'すみません', romaji: 'Sumimasen'),
    Phrase(francais: 'De rien', japonais: 'どういたしまして', romaji: 'Dou itashimashite'),
    Phrase(francais: 'Oui', japonais: 'はい', romaji: 'Hai'),
    Phrase(francais: 'Non', japonais: 'いいえ', romaji: 'Iie'),
  ],
  'Se présenter': [
    Phrase(francais: 'Je m''appelle...', japonais: 'わたしの名前は...です', romaji: 'Watashi no namae wa ... desu'),
    Phrase(francais: 'Enchanté', japonais: 'はじめまして', romaji: 'Hajimemashite'),
    Phrase(francais: 'Je suis français(e)', japonais: 'フランス人です', romaji: 'Furansu-jin desu'),
  ],
  'Se repérer': [
    Phrase(francais: 'Où est ... ?', japonais: '... はどこですか?', romaji: '... wa doko desu ka?'),
    Phrase(francais: 'La gare', japonais: '駅', romaji: 'Eki'),
    Phrase(francais: 'Les toilettes', japonais: 'トイレ', romaji: 'Toire'),
    Phrase(francais: 'L''hôtel', japonais: 'ホテル', romaji: 'Hoteru'),
    Phrase(francais: 'Ce train va à ... ?', japonais: 'この電車は...へ行きますか?', romaji: 'Kono densha wa ... e ikimasu ka?'),
    Phrase(francais: 'À gauche', japonais: '左', romaji: 'Hidari'),
    Phrase(francais: 'À droite', japonais: '右', romaji: 'Migi'),
    Phrase(francais: 'Tout droit', japonais: 'まっすぐ', romaji: 'Massugu'),
  ],
  'Restaurant': [
    Phrase(francais: 'Le menu, s''il vous plaît', japonais: 'メニューをお願いします', romaji: 'Menyuu o onegaishimasu'),
    Phrase(francais: 'C''est quoi ce plat ?', japonais: 'これは何ですか?', romaji: 'Kore wa nan desu ka?'),
    Phrase(francais: 'Je suis allergique à ...', japonais: '...のアレルギーがあります', romaji: '... no arerugii ga arimasu'),
    Phrase(francais: 'Sans viande, s''il vous plaît', japonais: '肉なしでお願いします', romaji: 'Niku nashi de onegaishimasu'),
    Phrase(francais: 'C''était délicieux', japonais: 'おいしかったです', romaji: 'Oishikatta desu'),
  ],
  'Argent & Shopping': [
    Phrase(francais: 'Combien ça coûte ?', japonais: 'いくらですか?', romaji: 'Ikura desu ka?'),
    Phrase(francais: 'Trop cher', japonais: '高すぎます', romaji: 'Taka sugimasu'),
    Phrase(francais: 'Je veux acheter ça', japonais: 'これを買いたいです', romaji: 'Kore o kaitai desu'),
    Phrase(francais: 'Avez-vous la taille M ?', japonais: 'Mサイズはありますか?', romaji: 'M saizu wa arimasu ka?'),
  ],
};

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pour blablater')),
      body: ListView(
        children: phrasesParCategorie.entries.map((entry) {
          return ExpansionTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: entry.value.map((phrase) {
              return ListTile(
                title: Text(phrase.francais),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phrase.japonais, style: const TextStyle(fontSize: 16)),
                      Text(phrase.romaji, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
