import 'package:flutter/material.dart';
import 'main.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final disposalCenters = [
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
        "supported": [
          {"icon": Icons.keyboard, "label": "Keyboard"},
          {"icon": Icons.memory, "label": "RAM Module"},
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: () {
            mainPageKey.currentState?.navigateTo(0); // ✅ Go back to Dashboard tab
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF10B981),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
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
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          // 🗺️ Map Section
          Stack(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/sample_map.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Text(
                      "5 Centers Nearby",
                      style: TextStyle(
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

          const SizedBox(height: 8),

          // 📋 Centers List
          Expanded(
            child: ListView.separated(
              itemCount: disposalCenters.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey.shade300),
              itemBuilder: (context, index) {
                final center = disposalCenters[index];
                final supported =
                (center["supported"] as List<Map<String, dynamic>>);

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Icon + Info + Directions
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Icon
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                              (center["iconColor"] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(center["icon"] as IconData,
                                color: center["iconColor"] as Color, size: 28),
                          ),
                          const SizedBox(width: 16),

                          // Center Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                Text(
                                  center["name"] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // ⭐ Rating Row
                                Row(
                                  children: [
                                    // Number rating
                                    Text(
                                      "${center["rating"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 6),

                                    // Stars
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        double rating = center["rating"] as double;
                                        if (rating >= starIndex + 1) {
                                          return const Icon(Icons.star, size: 16, color: Colors.amber);
                                        } else if (rating > starIndex && rating < starIndex + 1) {
                                          return const Icon(Icons.star_half, size: 16, color: Colors.amber);
                                        } else {
                                          return const Icon(Icons.star_border, size: 16, color: Colors.amber);
                                        }
                                      }),
                                    ),
                                    const SizedBox(width: 6),

                                    // Reviews count
                                    Text(
                                      "(${center["reviews"]})",
                                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                // Distance + Category
                                Text(
                                  "${center["distance"]} • ${center["category"]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Address
                                Text(center["address"] as String,
                                    style: const TextStyle(color: Colors.grey)),

                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(center["hours"] as String,
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Directions button
                          IconButton(
                            icon: const Icon(Icons.directions,
                                color: Color(0xFF10B981)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Opening directions to ${center["name"]}...")),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Supported disposables aligned with text
                      Padding(
                        padding: const EdgeInsets.only(left: 60), // align w/ text
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: supported.map((item) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                color: const Color(0xFF10B981),
                                size: 22,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
