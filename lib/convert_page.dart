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

  final double _euroToYenRate = 177.68;
  final double _yenToEuroRate = 1 / 177.68;

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

  Widget _buildExchangeChip(String euro, String yen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$euro = $yen¥',
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[800],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertisseur', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      // GestureDetector pour fermer le clavier quand on clique ailleurs
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            children: [
              // Section principale de conversion
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Champ Euro avec design amélioré
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: _euroController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          labelText: 'Euros (€)',
                          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                          prefixIcon: Container(
                            margin: EdgeInsets.all(12),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.euro_symbol, color: Colors.blue[800], size: 20),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        ),
                      ),
                    ),
                    
                    // Icône d'échange au centre
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                    ),
                    
                    // Champ Yen avec design amélioré
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: _yenController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          labelText: 'Yens (¥)',
                          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                          prefixIcon: Container(
                            margin: EdgeInsets.all(12),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.currency_yen, color: Colors.red[800], size: 20),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.0),
              
              // Section informations sur le taux
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[50]!, Colors.indigo[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue[100]!, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_up, size: 18, color: Colors.blue[700]),
                        SizedBox(width: 8),
                        Text(
                          'Taux de change actuel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 € = ${_euroToYenRate.toStringAsFixed(2)} ¥',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildExchangeChip('10€', (_euroToYenRate * 10).toStringAsFixed(0)),
                        _buildExchangeChip('50€', (_euroToYenRate * 50).toStringAsFixed(0)),
                        _buildExchangeChip('100€', (_euroToYenRate * 100).toStringAsFixed(0)),
                        _buildExchangeChip('500€', (_euroToYenRate * 500).toStringAsFixed(0)),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20.0),
              
              // Lien vers le taux de change avec design amélioré
              Container(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://www.google.com/finance/quote/EUR-JPY'),
                    );
                  },
                  icon: Icon(Icons.open_in_new, size: 16, color: Colors.grey[600]),
                  label: Text(
                    'Vérifier le taux de change en temps réel',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
