import 'package:flutter/material.dart';
import 'scan_details_page.dart';
import 'dispose_details_page.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  const CategoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final items = _getCategoryItems(title);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
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
            Text(
              "IDRenew",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Browse all $title",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // 🔹 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search $title...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Suggested Keywords
            Wrap(
              spacing: 8,
              children: [
                _buildSuggestionChip("Battery"),
                _buildSuggestionChip("Screen"),
                _buildSuggestionChip("Charger"),
                _buildSuggestionChip("Keyboard"),
              ],
            ),
            const SizedBox(height: 16),


            // 🔹 Items List
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isReusable = item["statusType"] == "reusable";

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: const Color(0xFFF9FAFB),
                    child: ListTile(
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (isReusable ? const Color(0xFF10B981) : Colors.red).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          item["icon"] as IconData,
                          color: isReusable ? const Color(0xFF10B981) : Colors.red,
                        ),
                      ),
                      title: Text(item["title"] as String),
                      subtitle: Text(
                        item["status"] as String,
                        style: TextStyle(
                          color: isReusable ? const Color(0xFF10B981) : Colors.red,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (isReusable) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanDetailsPage(
                                partName: item["title"] as String,
                                status: item["status"] as String,
                                statusColor: const Color(0xFF10B981),
                                icon: item["icon"] as IconData,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisposeDetailsPage(
                                partName: item["title"] as String,
                                status: item["status"] as String,
                                icon: item["icon"] as IconData,
                              ),
                            ),
                          );
                        }
                      },

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Items by category
  List<Map<String, dynamic>> _getCategoryItems(String category) {
    switch (category) {
      case "Phone Parts":
        return [
          {
            "title": "Phone Battery",
            "status": "✓ Reusable - 3 options found",
            "statusType": "reusable",
            "icon": Icons.battery_full,
          },
          {
            "title": "Phone Screen",
            "status": "⚠ Dispose - cracked",
            "statusType": "dispose",
            "icon": Icons.phone_android,
          },
        ];
      case "Laptop Parts":
        return [
          {
            "title": "RAM Module",
            "status": "⚠ Dispose - 2 centers nearby",
            "statusType": "dispose",
            "icon": Icons.memory,
          },
          {
            "title": "Laptop Keyboard",
            "status": "✓ Reusable - 4 options",
            "statusType": "reusable",
            "icon": Icons.keyboard,
          },
        ];
      case "Components":
        return [
          {
            "title": "Hard Drive",
            "status": "⚠ Dispose - 4 centers nearby",
            "statusType": "dispose",
            "icon": Icons.storage,
          },
          {
            "title": "Capacitor",
            "status": "✓ Reusable - for small circuits",
            "statusType": "reusable",
            "icon": Icons.electrical_services,
          },
        ];
      case "Accessories":
        return [
          {
            "title": "Phone Charger",
            "status": "✓ Reusable - 7 options found",
            "statusType": "reusable",
            "icon": Icons.power,
          },
          {
            "title": "Earphones",
            "status": "⚠ Dispose - broken wires",
            "statusType": "dispose",
            "icon": Icons.headphones,
          },
        ];
      default:
        return [];
    }
  }
}

Widget _buildSuggestionChip(String label) {
  return Chip(
    label: Text(label),
    backgroundColor: const Color(0xFFDCFCE7),
    labelStyle: const TextStyle(color: Color(0xFF10B981)),
    padding: const EdgeInsets.symmetric(horizontal: 8),
  );
}