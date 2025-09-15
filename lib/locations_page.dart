import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'main.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  Map<String, dynamic>? _selectedCenter; // currently selected center

  final List<Map<String, dynamic>> disposalCenters = [
    {
      "name": "EcoTech Recycling Center",
      "distance": "1.2 km",
      "category": "Electronics & Battery Disposal",
      "address": "123 Green Street, Downtown",
      "hours": "Open until 6 PM",
      "rating": 4.8,
      "reviews": 29,
      "icon": Icons.recycling,
      "iconColor": const Color(0xFF10B981),
      "coords": LatLng(7.0731, 125.6131),
      "supported": [
        {"icon": Icons.memory, "label": "RAM Module"},
        {"icon": Icons.storage, "label": "Hard Drive"},
        {"icon": Icons.keyboard, "label": "Keyboard"},
        {"icon": Icons.battery_full, "label": "Battery"},
      ],
    },
    {
      "name": "Best Buy Recycling",
      "distance": "2.1 km",
      "category": "Consumer Electronics",
      "address": "456 Tech Avenue, Mall District",
      "hours": "Open until 9 PM",
      "rating": 4.5,
      "reviews": 41,
      "icon": Icons.laptop,
      "iconColor": const Color(0xFF3B82F6),
      "coords": LatLng(7.0700, 125.6200),
      "supported": [
        {"icon": Icons.memory, "label": "RAM Module"},
        {"icon": Icons.cable, "label": "Cables"},
        {"icon": Icons.laptop_mac, "label": "Laptop Screen"},
      ],
    },
    {
      "name": "Green Earth Disposal",
      "distance": "3.5 km",
      "category": "Hazardous Materials",
      "address": "789 Eco Park Road, Industrial Zone",
      "hours": "Closes at 5 PM",
      "rating": 4.7,
      "reviews": 18,
      "icon": Icons.energy_savings_leaf,
      "iconColor": const Color(0xFF10B981),
      "coords": LatLng(7.0650, 125.6220),
      "supported": [
        {"icon": Icons.keyboard, "label": "Keyboard"},
        {"icon": Icons.memory, "label": "RAM Module"},
      ],
    },
  ];

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable location services")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(pos.latitude, pos.longitude);
    });
    _mapController.move(_currentLocation!, 15);
  }

  @override
  Widget build(BuildContext context) {
    final showingList = _selectedCenter == null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: () {
            mainPageKey.currentState?.navigateTo(0);
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.recycling, color: Colors.white),
              ),
              const SizedBox(width: 8),
              const Text(
                "IDRenew",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search + Auto-locate
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search location",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF10B981),
                  child: IconButton(
                    icon: const Icon(Icons.my_location, color: Colors.white),
                    onPressed: _getCurrentLocation,
                  ),
                ),
              ],
            ),
          ),

          // 🗺️ Map Section
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(7.0731, 125.6131),
                      initialZoom: 13,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      if (_currentLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.my_location,
                                  color: Colors.blue, size: 36),
                            ),
                          ],
                        ),
                      MarkerLayer(
                        markers: disposalCenters.map((center) {
                          return Marker(
                            point: center["coords"] as LatLng,
                            width: 50,
                            height: 50,
                            child: Icon(center["icon"] as IconData,
                                color: center["iconColor"] as Color, size: 40),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                if (showingList)
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: Text(
                          "${disposalCenters.length} Centers Nearby",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 📋 List OR Single Details
          Expanded(
            child: showingList
                ? _buildCentersList()
                : _buildCenterDetails(_selectedCenter!),
          ),
        ],
      ),
    );
  }

  Widget _buildCentersList() {
    return ListView.separated(
      itemCount: disposalCenters.length,
      separatorBuilder: (context, index) =>
          Divider(height: 1, color: Colors.grey.shade300),
      itemBuilder: (context, index) {
        final center = disposalCenters[index];
        return ListTile(
          leading: Icon(center["icon"] as IconData,
              color: center["iconColor"] as Color),
          title: Text(center["name"] as String),
          subtitle: Text("${center["distance"]} • ${center["category"]}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            setState(() {
              _selectedCenter = center;
            });
            _mapController.move(center["coords"] as LatLng, 16);
          },
        );
      },
    );
  }

  Widget _buildCenterDetails(Map<String, dynamic> center) {
    final supported = (center["supported"] as List<Map<String, dynamic>>);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedCenter = null;
                  });
                },
              ),
              Text(center["name"] as String,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Icon(center["icon"] as IconData,
                  color: center["iconColor"] as Color, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${center["distance"]} • ${center["category"]}",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87)),
                    Text(center["address"] as String,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(center["hours"] as String,
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),

          // ⭐ Rating
          Row(
            children: [
              Text("${center["rating"]}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              const SizedBox(width: 6),
              Row(
                children: List.generate(5, (starIndex) {
                  double rating = center["rating"] as double;
                  if (rating >= starIndex + 1) {
                    return const Icon(Icons.star,
                        size: 16, color: Colors.amber);
                  } else if (rating > starIndex && rating < starIndex + 1) {
                    return const Icon(Icons.star_half,
                        size: 16, color: Colors.amber);
                  } else {
                    return const Icon(Icons.star_border,
                        size: 16, color: Colors.amber);
                  }
                }),
              ),
              const SizedBox(width: 6),
              Text("(${center["reviews"]})",
                  style:
                  const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),

          const SizedBox(height: 16),

          const Text("Supported items:",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: supported.map((item) {
              return Chip(
                label: Text(item["label"] as String),
                avatar: Icon(item["icon"] as IconData,
                    size: 18, color: const Color(0xFF10B981)),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Opening directions to ${center["name"]}...")),
              );
            },
            icon: const Icon(Icons.directions, color: Colors.white),
            label: const Text("Get Directions",
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
