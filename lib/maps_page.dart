import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart' as xml;

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
    'assets/osm/tokyo/m.osm': Colors.red,
    'assets/osm/tokyo/n.osm': Colors.teal,
    'assets/osm/tokyo/t.osm': Colors.lightBlue,
    'assets/osm/tokyo/y.osm': Colors.yellowAccent,
    'assets/osm/tokyo/z.osm': Colors.purple,

    'assets/osm/kyoto/karasuma.osm': Colors.green,
    'assets/osm/kyoto/tozai.osm': Colors.red,

    'assets/osm/osaka/midosuji.osm': Colors.red,
    'assets/osm/osaka/chuo.osm': Colors.greenAccent,
    'assets/osm/osaka/imazatosuji.osm': Colors.orange,
    'assets/osm/osaka/nagahori-tsurumi-ryokuchi.osm': Colors.lightGreen,
    'assets/osm/osaka/nanko-port-own.osm': Colors.lightBlue,
    'assets/osm/osaka/sakaisuji.osm': Colors.brown,
    'assets/osm/osaka/senichimae.osm': Colors.pink,
    'assets/osm/osaka/tanimachi.osm': Colors.purple,
    'assets/osm/osaka/yotsubashi.osm': Colors.blueAccent,
  };

  final String thunderforestApiKey = '<TOKEN API>';

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
      print('Error loading map data: $e');
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
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Wrap(
                    spacing: 1.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showMetroMapImage(context, 'assets/kyotometro.png');
                        },
                        child: Text('Kyoto Metro Map'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showMetroMapImage(context, 'assets/tokyometro.png');
                        },
                        child: Text('Tokyo Metro Map'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showMetroMapImage(context, 'assets/osakametro.png');
                        },
                        child: Text('Osaka Metro Map'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Afficher/Cacher les lignes de la carte',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children:
                        groupedLines.entries.map((entry) {
                          String city = entry.key;
                          List<String> lines = entry.value;

                          return ExpansionTile(
                            title: Text(
                              "${city[0].toUpperCase()}${city.substring(1)}",
                            ),
                            children:
                                lines.map((line) {
                                  return CheckboxListTile(
                                    title: RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          const TextSpan(text: 'Ligne '),
                                          TextSpan(
                                            text:
                                                line
                                                    .split('/')
                                                    .last
                                                    .split('.')
                                                    .first
                                                    .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: lineColors[line],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    value: lineVisibility[line],
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        lineVisibility[line] = value!;
                                      });
                                      setState(() {
                                        lineVisibility[line] = value!;
                                      });
                                    },
                                  );
                                }).toList(),
                          );
                        }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
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
      appBar: AppBar(
        title: const Text('Metro Map'),
        backgroundColor: const Color.fromARGB(255, 190, 200, 200),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showLineVisibilityBottomSheet(context);
            },
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(35.68, 139.76),
                  initialZoom: 11.0,
                  interactionOptions: const InteractionOptions(
                    flags:
                        InteractiveFlag.pinchZoom |
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
                    polylines:
                        lineStops.entries
                            .where((entry) => lineVisibility[entry.key] == true)
                            .map((entry) {
                              final line = entry.key;
                              final stops = entry.value;
                              final color = lineColors[line];
                              return Polyline(
                                points: stops,
                                color: color!,
                                strokeWidth: 4.0,
                              );
                            })
                            .toList(),
                  ),
                  MarkerLayer(
                    markers:
                        lineStops.entries
                            .where((entry) => lineVisibility[entry.key] == true)
                            .expand(
                              (entry) => entry.value.map((stop) {
                                final line = entry.key;
                                final color = lineColors[line];
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
                                          selectedStops.add(stop);
                                        }
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.subway,
                                          color: color,
                                          size: 14.0,
                                        ),
                                        if (selectedStops.contains(stop))
                                          Positioned(
                                            bottom: 50,
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                stopNames[stop] ?? 'Unknown',
                                                style: TextStyle(
                                                  backgroundColor: Colors.white,
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                            .toList(),
                  ),
                ],
              ),
    );
  }
}
