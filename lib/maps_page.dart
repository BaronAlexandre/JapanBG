import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart' as xml;
import 'theme.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Map<String, List<LatLng>> lineStops = {};
  Map<LatLng, String> stopNames = {};
  Set<LatLng> selectedStops = {};
  bool isLoading = true;
  Map<String, bool> lineVisibility = {};

  final List<String> metroLines = [
    'assets/osm/tokyo/c.osm',
    'assets/osm/tokyo/f.osm',
    'assets/osm/tokyo/g.osm',
    'assets/osm/tokyo/h.osm',
    'assets/osm/tokyo/m.osm',
    'assets/osm/tokyo/n.osm',
    'assets/osm/tokyo/t.osm',
    'assets/osm/tokyo/y.osm',
    'assets/osm/tokyo/z.osm',

    'assets/osm/kyoto/karasuma.osm',
    'assets/osm/kyoto/tozai.osm',

    'assets/osm/osaka/midosuji.osm',
    'assets/osm/osaka/chuo.osm',
    'assets/osm/osaka/imazatosuji.osm',
    'assets/osm/osaka/nagahori-tsurumi-ryokuchi.osm',
    'assets/osm/osaka/nanko-port-own.osm',
    'assets/osm/osaka/sakaisuji.osm',
    'assets/osm/osaka/senichimae.osm',
    'assets/osm/osaka/tanimachi.osm',
    'assets/osm/osaka/yotsubashi.osm',
  ];

  final Map<String, Color> lineColors = {
    'assets/osm/tokyo/c.osm': Colors.green,
    'assets/osm/tokyo/f.osm': Colors.brown,
    'assets/osm/tokyo/g.osm': Colors.orange,
    'assets/osm/tokyo/h.osm': Colors.grey,
    'assets/osm/tokyo/m.osm': JapanTheme.primaryRed,
    'assets/osm/tokyo/n.osm': Colors.teal,
    'assets/osm/tokyo/t.osm': Colors.lightBlue,
    'assets/osm/tokyo/y.osm': Colors.yellowAccent,
    'assets/osm/tokyo/z.osm': Colors.purple,

    'assets/osm/kyoto/karasuma.osm': Colors.green,
    'assets/osm/kyoto/tozai.osm': JapanTheme.primaryRed,

    'assets/osm/osaka/midosuji.osm': JapanTheme.primaryRed,
    'assets/osm/osaka/chuo.osm': Colors.greenAccent,
    'assets/osm/osaka/imazatosuji.osm': Colors.orange,
    'assets/osm/osaka/nagahori-tsurumi-ryokuchi.osm': Colors.lightGreen,
    'assets/osm/osaka/nanko-port-own.osm': Colors.lightBlue,
    'assets/osm/osaka/sakaisuji.osm': Colors.brown,
    'assets/osm/osaka/senichimae.osm': Colors.pink,
    'assets/osm/osaka/tanimachi.osm': Colors.purple,
    'assets/osm/osaka/yotsubashi.osm': Colors.blueAccent,
  };

  final String thunderforestApiKey = 'b575fa813b154b7aac98d6693a4d6beb';

  @override
  void initState() {
    super.initState();
    lineVisibility = {for (var line in metroLines) line: true};
    loadMapData();
  }

  Future<void> loadMapData() async {
    try {
      for (String file in metroLines) {
        final String data = await rootBundle.loadString(file);
        final document = xml.XmlDocument.parse(data);
        final relation = document.findAllElements('relation').first;

        List<LatLng> stops = [];
        relation
            .findElements('member')
            .where((element) => element.getAttribute('role') == 'stop')
            .forEach((element) {
              final lat = double.parse(element.getAttribute('lat')!);
              final lon = double.parse(element.getAttribute('lon')!);
              final latLng = LatLng(lat, lon);

              final name = element.getAttribute('name') ?? 'Unknown';
              final nameEn = element.getAttribute('name_en') ?? 'Unknown';

              stopNames[latLng] = '$name / $nameEn';
              stops.add(latLng);
            });

        setState(() {
          lineStops[file] = stops;
        });
      }
    } catch (e) {
      // Erreur lors du chargement des données de la carte
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showLineVisibilityBottomSheet(BuildContext context) {
    Map<String, List<String>> groupedLines = {};
    for (String line in metroLines) {
      String city = line.split('/')[2];
      if (!groupedLines.containsKey(city)) {
        groupedLines[city] = [];
      }
      groupedLines[city]!.add(line);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Header
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.tune, color: Colors.orange[600]),
                        SizedBox(width: 12),
                        Text(
                          'Configuration des lignes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Quick actions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionButton(
                            'Tout afficher',
                            Icons.visibility,
                            Colors.green,
                            () {
                              setModalState(() {
                                for (String line in metroLines) {
                                  lineVisibility[line] = true;
                                }
                              });
                              setState(() {
                                for (String line in metroLines) {
                                  lineVisibility[line] = true;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildQuickActionButton(
                            'Tout masquer',
                            Icons.visibility_off,
                            Colors.red,
                            () {
                              setModalState(() {
                                for (String line in metroLines) {
                                  lineVisibility[line] = false;
                                }
                              });
                              setState(() {
                                for (String line in metroLines) {
                                  lineVisibility[line] = false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Lines list
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: groupedLines.entries.map((entry) {
                        String city = entry.key;
                        List<String> lines = entry.value;
                        
                        final cityColors = {
                          'tokyo': JapanTheme.primaryRed,
                          'kyoto': Colors.purple,
                          'osaka': Colors.orange,
                        };
                        
                        final cityColor = cityColors[city] ?? Colors.blue;

                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: cityColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: cityColor.withOpacity(0.2)),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.all(16),
                              childrenPadding: EdgeInsets.only(bottom: 8),
                              leading: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: cityColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.location_city, color: cityColor, size: 20),
                              ),
                              title: Text(
                                "${city[0].toUpperCase()}${city.substring(1)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              subtitle: Text(
                                '${lines.length} lignes',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              children: lines.map((line) {
                                final lineName = line.split('/').last.split('.').first.toUpperCase();
                                final lineColor = lineColors[line]!;
                                
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    title: Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: lineColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Ligne $lineName',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: lineVisibility[line],
                                    activeColor: lineColor,
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        lineVisibility[line] = value!;
                                      });
                                      setState(() {
                                        lineVisibility[line] = value!;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMetroMapImage(BuildContext context, String imagePath) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: GestureDetector(
                onTap: () {},
                child: InteractiveViewer(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FA),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header moderne
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.train, color: Colors.blue[700], size: 24),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan du Métro',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Tokyo • Kyoto • Osaka',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            icon: Icon(Icons.map, color: Colors.green[600]),
                            onPressed: () => _showMetroMapsDialog(context),
                          ),
                        ),
                        SizedBox(width: 8),
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
                            icon: Icon(Icons.tune, color: Colors.orange[600]),
                            onPressed: () => showLineVisibilityBottomSheet(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Carte avec loading moderne
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: isLoading
                        ? Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Chargement du plan du métro...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Préparation des lignes et stations',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(35.68, 139.76),
                              initialZoom: 11.0,
                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.pinchZoom |
                                    InteractiveFlag.drag |
                                    InteractiveFlag.scrollWheelZoom,
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=$thunderforestApiKey',
                                tileProvider: CancellableNetworkTileProvider(),
                              ),
                              PolylineLayer(
                                polylines: lineStops.entries
                                    .where((entry) => lineVisibility[entry.key] == true)
                                    .map((entry) {
                                      final line = entry.key;
                                      final stops = entry.value;
                                      final color = lineColors[line]!;
                                      return Polyline(
                                        points: stops,
                                        color: color,
                                        strokeWidth: 5.0,
                                      );
                                    })
                                    .toList(),
                              ),
                              MarkerLayer(
                                markers: lineStops.entries
                                    .where((entry) => lineVisibility[entry.key] == true)
                                    .expand((entry) => entry.value.map((stop) {
                                          final line = entry.key;
                                          final color = lineColors[line]!;
                                          final isSelected = selectedStops.contains(stop);
                                          
                                          return Marker(
                                            width: 80.0,
                                            height: 80.0,
                                            point: stop,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (selectedStops.contains(stop)) {
                                                    selectedStops.remove(stop);
                                                  } else {
                                                    selectedStops.clear();
                                                    selectedStops.add(stop);
                                                  }
                                                });
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  // Station marker
                                                  Container(
                                                    width: isSelected ? 20 : 16,
                                                    height: isSelected ? 20 : 16,
                                                    decoration: BoxDecoration(
                                                      color: color,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: isSelected ? 3 : 2,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: color.withOpacity(0.4),
                                                          blurRadius: isSelected ? 8 : 4,
                                                          offset: Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Station name popup
                                                  if (isSelected)
                                                    Positioned(
                                                      bottom: 30,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.2),
                                                              blurRadius: 8,
                                                              offset: Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          stopNames[stop] ?? 'Station inconnue',
                                                          style: TextStyle(
                                                            color: Colors.grey[800],
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }))
                                    .toList(),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showMetroMapsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.map, color: Colors.green[600]),
                    SizedBox(width: 8),
                    Text(
                      'Plans officiels du métro',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    _buildMetroMapButton(
                      'Plan Métro Tokyo',
                      '🇯🇵',
                      Colors.red,
                      () => showMetroMapImage(context, 'assets/tokyometro.png'),
                    ),
                    SizedBox(height: 12),
                    _buildMetroMapButton(
                      'Plan Métro Kyoto',
                      '⛩️',
                      Colors.purple,
                      () => showMetroMapImage(context, 'assets/kyotometro.png'),
                    ),
                    SizedBox(height: 12),
                    _buildMetroMapButton(
                      'Plan Métro Osaka',
                      '🏯',
                      Colors.orange,
                      () => showMetroMapImage(context, 'assets/osakametro.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetroMapButton(String title, String emoji, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 24)),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
