import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";

  // Dummy suggestions
  final List<String> suggestions = [
    "Phone Battery",
    "RAM Module",
    "Hard Drive",
    "Laptop Keyboard",
    "Screen Display",
    "Charging Cable",
  ];

  @override
  Widget build(BuildContext context) {
    // Filter results based on query
    final results = suggestions
        .where((s) => s.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Search Parts",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: "Search for device parts...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📌 Suggestions / Results
          Expanded(
            child: _query.isEmpty
                ? _buildSuggestions()
                : _buildResults(results),
          ),
        ],
      ),
    );
  }

  // 🟢 Suggestion List
  Widget _buildSuggestions() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text("Suggestions",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: suggestions.map((s) {
            return ActionChip(
              backgroundColor: const Color(0xFF10B981).withOpacity(0.1),
              label: Text(s, style: const TextStyle(color: Color(0xFF10B981))),
              onPressed: () {
                setState(() {
                  _query = s;
                  _controller.text = s;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // 🔎 Search Results
  Widget _buildResults(List<String> results) {
    if (results.isEmpty) {
      return const Center(
        child: Text("No results found",
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.memory, color: Color(0xFF10B981)),
            ),
            title: Text(results[index]),
            subtitle: const Text("Tap to view details"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PartDetailsPage(
                    partName: results[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// 🟡 Placeholder for detailed part page
class PartDetailsPage extends StatelessWidget {
  final String partName;
  const PartDetailsPage({super.key, required this.partName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(partName),
      ),
      body: Center(
        child: Text("Details about $partName",
            style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
