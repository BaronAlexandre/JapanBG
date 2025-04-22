import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  ConvertPageState createState() => ConvertPageState();
}

class ConvertPageState extends State<ConvertPage> {
  final TextEditingController _euroController = TextEditingController();
  final TextEditingController _yenController = TextEditingController();
  // Taux de change https://www.google.com/finance/quote/EUR-JPY
  final double _euroToYenRate = 161.5620;
  final double _yenToEuroRate = 1 / 161.5620;

  void _convertEuroToYen() {
    final euroAmount = double.tryParse(_euroController.text) ?? 0;
    final yenAmount = euroAmount * _euroToYenRate;
    setState(() {
      _yenController.text = yenAmount.toStringAsFixed(4);
    });
  }

  void _convertYenToEuro() {
    final yenAmount = double.tryParse(_yenController.text) ?? 0;
    final euroAmount = yenAmount * _yenToEuroRate;
    setState(() {
      _euroController.text = euroAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertisseur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            ElevatedButton(
              onPressed: _convertEuroToYen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.euro_symbol),
                  Icon(Icons.arrow_forward),
                  Icon(Icons.currency_yen),
                ],
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
            ElevatedButton(
              onPressed: _convertYenToEuro,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_yen),
                  Icon(Icons.arrow_forward),
                  Icon(Icons.euro_symbol),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
