import 'package:flutter/material.dart';

class ScanDetailsPage extends StatelessWidget {
  final String partName;
  final String status;
  final Color statusColor;
  final IconData icon;

  const ScanDetailsPage({
    super.key,
    required this.partName,
    required this.status,
    required this.statusColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar with just branding
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

      // ✅ Body content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Header row (moved phone battery info here)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: statusColor, size: 32),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(status, style: TextStyle(color: statusColor)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ Status Card
            Card(
              color: statusColor == const Color(0xFF10B981)
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  statusColor == const Color(0xFF10B981)
                      ? Icons.check_circle
                      : Icons.error,
                  color: statusColor,
                ),
                title: Text(
                  statusColor == const Color(0xFF10B981)
                      ? "This part can be reused!"
                      : "This part should be disposed!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                subtitle: Text(
                  statusColor == const Color(0xFF10B981)
                      ? "Great for DIY projects and repairs"
                      : "Find nearby disposal centers",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Why It's Reusable
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
                    const Text(
                      "Why It's Reusable",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const _BulletPoint("Still functional"),
                    const _BulletPoint("No physical damage detected"),
                    const _BulletPoint("Compatible with multiple models"),
                    const SizedBox(height: 8),

                    // ✅ Lifespan Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Typical Lifespan: ",
                              style: TextStyle(
                                color: Color(0xFF1E40AF),
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: "2–3 more years with proper care",
                              style: const TextStyle(
                                  color: Color(0xFF1E40AF), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ How You Can Reuse
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
                      "How You Can Reuse This",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const ListTile(
                        leading:
                        Icon(Icons.build, color: Color(0xFF10B981)),
                        title: Text("DIY Projects"),
                        subtitle: Text(
                            "Power banks, LED lights, small electronics"),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const ListTile(
                        leading:
                        Icon(Icons.settings, color: Color(0xFF10B981)),
                        title: Text("Repair & Upgrade"),
                        subtitle:
                        Text("Replace in compatible devices"),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("View All Options",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Learn How To Reuse
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
                      "Learn How To Reuse",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    // Replace with Youtube player later
                    _VideoPlaceholder(),
                    SizedBox(height: 12),
                    _BulletPoint("Battery replacement guide",
                        icon: Icons.file_copy),
                    _BulletPoint("DIY power bank project",
                        icon: Icons.file_copy),
                    _BulletPoint("Safety tips", icon: Icons.file_copy),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ If You Can't Reuse
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "If You Can't Reuse This Part",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "We'll help you dispose of it safely...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black54),
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

// 🔹 Custom bullet point widget
class _BulletPoint extends StatelessWidget {
  final String text;
  final IconData icon;

  const _BulletPoint(this.text, {this.icon = Icons.check_circle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// 🔹 Placeholder for YouTube tutorial
class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.play_circle_fill,
            color: Colors.white, size: 48),
      ),
    );
  }
}
