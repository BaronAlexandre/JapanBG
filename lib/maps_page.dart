import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart' as xml;

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  List<LatLng> stops = [];
  Map<LatLng, String> stopNames = {}; // Mapping from LatLng to stop names
  Set<LatLng> selectedStops = {}; // Keeps track of selected stops
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMapData();
  }

  Future<void> loadMapData() async {
    try {
      final String data = await rootBundle.loadString('assets/osm/tokyo/g.osm');
      final document = xml.XmlDocument.parse(data);
      final relation = document.findAllElements('relation').first;

      // Parse stops
      relation
          .findElements('member')
          .where((element) => element.getAttribute('role') == 'stop')
          .forEach((element) {
            final lat = double.parse(element.getAttribute('lat')!);
            final lon = double.parse(element.getAttribute('lon')!);
            final latLng = LatLng(lat, lon);

            // Get the name and name_en attributes
            final name = element.getAttribute('name') ?? 'Unknown';
            final nameEn = element.getAttribute('name_en') ?? 'Unknown';

            stopNames[latLng] = '$name / $nameEn'; // Combine both names

            stops.add(latLng);
          });
    } catch (e) {
      // Handle errors, e.g., show a snackbar or dialog
      print('Error loading map data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metro Map')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(35.68, 139.76), // Center of the map
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c', 'd'],
                  ),
                  // Only render PolylineLayer if `stops` is not empty
                  if (stops.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: stops,
                          color: Colors.blue,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  MarkerLayer(
                    markers:
                        stops.map((stop) {
                          return Marker(
                            width: 80.0,
                            height: 80.0,
                            point: stop,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedStops.contains(stop)) {
                                    selectedStops.remove(
                                      stop,
                                    ); // Unselect the stop
                                  } else {
                                    selectedStops.add(stop); // Select the stop
                                  }
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // The actual marker icon
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40.0,
                                  ),
                                  // Displaying the name above the marker when selected
                                  if (selectedStops.contains(stop))
                                    Positioned(
                                      bottom:
                                          50, // This places the name above the marker
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          stopNames[stop] ?? 'Unknown',
                                          style: TextStyle(
                                            backgroundColor: Colors.white,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
    );
  }
}
