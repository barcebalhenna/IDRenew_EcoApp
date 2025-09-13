import 'package:flutter/material.dart';
import 'scan_details_page.dart';
import 'dispose_details_page.dart';
import 'main.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> _historyItems = [
    {
      "title": "Phone Battery",
      "status": "✓ Reusable - 3 options found",
      "statusType": "reusable",
      "icon": Icons.battery_full,
    },
    {
      "title": "RAM Module",
      "status": "⚠ Dispose - 2 centers nearby",
      "statusType": "dispose",
      "icon": Icons.memory,
    },
    {
      "title": "Laptop Screen",
      "status": "✓ Reusable - 5 options found",
      "statusType": "reusable",
      "icon": Icons.laptop,
    },
    {
      "title": "Hard Drive",
      "status": "⚠ Dispose - 4 centers nearby",
      "statusType": "dispose",
      "icon": Icons.storage,
    },
    {
      "title": "Phone Charger",
      "status": "✓ Reusable - 7 options found",
      "statusType": "reusable",
      "icon": Icons.power,
    },
    {
      "title": "Keyboard Keys",
      "status": "⚠ Dispose - 1 center nearby",
      "statusType": "dispose",
      "icon": Icons.keyboard,
    },
    {
      "title": "Phone Camera",
      "status": "✓ Reusable - 2 options found",
      "statusType": "reusable",
      "icon": Icons.camera_alt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedFilter == "All"
        ? _historyItems
        : _historyItems
        .where((item) =>
    item["statusType"] == _selectedFilter.toLowerCase())
        .toList();

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Scan History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "View all your previously scanned items",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // 🔹 Filter buttons
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildFilterChip("All Items", "All"),
                  _buildFilterChip("Reusable", "Reusable"),
                  _buildFilterChip("Dispose", "Dispose"),
                ],
              ),
            ),

            // 🔹 History list
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  final isReusable = item["statusType"] == "reusable";

                  return InkWell(
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 2,
                      color: const Color(0xFFF9FAFB),
                      child: ListTile(
                        leading: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: (isReusable
                                ? const Color(0xFF10B981)
                                : Colors.red)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            item["icon"] as IconData,
                            color:
                            isReusable ? const Color(0xFF10B981) : Colors.red,
                          ),
                        ),
                        title: Text(item["title"]),
                        subtitle: Text(
                          item["status"],
                          style: TextStyle(
                            color: isReusable
                                ? const Color(0xFF10B981)
                                : Colors.red,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
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

  Widget _buildFilterChip(String label, String filter) {
    final isSelected = _selectedFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedFilter = filter);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
