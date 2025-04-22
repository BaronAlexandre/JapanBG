import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  ConvertPageState createState() => ConvertPageState();
}

class ConvertPageState extends State<ConvertPage> {
  final TextEditingController _euroController = TextEditingController();
  final TextEditingController _yenController = TextEditingController();

  final double _euroToYenRate = 161.5620;
  final double _yenToEuroRate = 1 / 161.5620;

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();

    _euroController.addListener(() {
      if (_isUpdating) return;
      _isUpdating = true;
      final euroAmount = double.tryParse(_euroController.text) ?? 0;
      final yenAmount = euroAmount * _euroToYenRate;
      _yenController.text = yenAmount.toStringAsFixed(4);
      _isUpdating = false;
    });

    _yenController.addListener(() {
      if (_isUpdating) return;
      _isUpdating = true;
      final yenAmount = double.tryParse(_yenController.text) ?? 0;
      final euroAmount = yenAmount * _yenToEuroRate;
      _euroController.text = euroAmount.toStringAsFixed(2);
      _isUpdating = false;
    });
  }

  @override
  void dispose() {
    _euroController.dispose();
    _yenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Convertisseur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _euroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Montant en Euros',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.euro_symbol),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _yenController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Montant en Yens',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_yen),
              ),
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(text: 'Le taux de change est '),
                  TextSpan(
                    text: _euroToYenRate.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text("S'il a varié, il est disponible ici : "),
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri.parse('https://www.google.com/finance/quote/EUR-JPY'),
                    );
                  },
                  child: Text(
                    'Voir le taux de change',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
