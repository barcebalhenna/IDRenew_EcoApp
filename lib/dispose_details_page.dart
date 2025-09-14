import 'package:flutter/material.dart';

class DisposeDetailsPage extends StatelessWidget {
  final String partName;
  final String status;
  final IconData icon;

  const DisposeDetailsPage({
    super.key,
    required this.partName,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Part Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.red, size: 32),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(Damaged)",
                      style: TextStyle(color: Colors.red[700], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Status Card
            Card(
              color: const Color(0xFFFFEDD5),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.warning_outlined, color: Colors.black),
                title: const Text(
                  "This part needs safe disposal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A3412),
                  ),
                ),
                subtitle: const Text(
                  "Do not attempt to reuse",
                  style: TextStyle(
                    color: Color(0xFFC2410C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Why This Cannot Be Reused
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.warning_rounded, color: Colors.red, size: 30),
                        SizedBox(width: 6),
                        Text(
                          "Why This Cannot Be Reused",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _DisposePoint("Potential fire hazard"),
                    const _DisposePoint("Toxic chemical leakage risk"),
                    const _DisposePoint("Obsolete technology - unsafe"),
                    const SizedBox(height: 8),

                    // ⚠ Warning box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Do not attempt to repair or reuse this component",
                        style: TextStyle(
                          color: Color(0xFF991B1B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Before You Dispose
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Before You Dispose",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    _NumberedStep(
                        number: "1",
                        text: "Place in original packaging or wrap in newspaper"),
                    _NumberedStep(
                        number: "2", text: "Keep terminals covered with tape"),
                    _NumberedStep(
                        number: "3",
                        text: "Store in cool, dry place until disposal"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Nearby Disposal Centers
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nearby Disposal Centers",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // Placeholder for mini map
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.map, size: 40, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Example centers
                    const _CenterItem(
                        name: "EcoCenter Downtown",
                        details: "Open until 6 PM • 0.5 mi"),
                    const _CenterItem(
                        name: "GreenTech Recycling",
                        details: "Open until 9 PM • 1.2 mi"),
                    const _CenterItem(
                        name: "City Waste Management",
                        details: "Open until 5 PM • 2.1 mi"),

                    const SizedBox(height: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Get Directions",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 6),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF10B981)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "View All Centers",
                            style: TextStyle(color: Color(0xFF10B981)),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Additional Help
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Additional Help",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    _HelpItem(
                        icon: Icons.account_balance,
                        text: "Local Government E-Waste Program"),
                    _HelpItem(
                        icon: Icons.factory,
                        text: "Manufacturer Take-Back Program"),
                    _HelpItem(
                        icon: Icons.public,
                        text: "Environmental Protection Guidelines"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Bullets for why this cannot be reused
class _DisposePoint extends StatelessWidget {
  final String text;
  const _DisposePoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// 🔹 Numbered Steps
class _NumberedStep extends StatelessWidget {
  final String number;
  final String text;
  const _NumberedStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFF10B981),
            child: Text(number,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// 🔹 Disposal Centers Item
class _CenterItem extends StatelessWidget {
  final String name;
  final String details;

  const _CenterItem({
    required this.name,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on, color: Color(0xFF10B981), size: 22), // bullet icon
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(details,
                    style: const TextStyle(color: Color(0xFF10B981))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// 🔹 Help Items
class _HelpItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HelpItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
