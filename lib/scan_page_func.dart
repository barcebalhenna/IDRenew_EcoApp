import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras[0], // use the back camera
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();
    setState(() {
      _isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleFlash() async {
    if (_controller == null) return;
    _flashOn = !_flashOn;
    await _controller!.setFlashMode(
      _flashOn ? FlashMode.torch : FlashMode.off,
    );
    setState(() {});
  }

  void _takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final picture = await _controller!.takePicture();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Photo saved at ${picture.path}")),
    );
  }

  void _openGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Open gallery (to implement)")),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: const Icon(Icons.recycling, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text("IDRenew",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hint bar stays the same
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Point camera at device parts",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              // ✅ Replace placeholder with camera preview
              SizedBox(
                width: double.infinity,
                height: 400,
                child: _isCameraReady
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CameraPreview(_controller!),
                )
                    : const Center(child: CircularProgressIndicator()),
              ),

              // Bottom camera controls
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: _openGallery,
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      iconSize: 32,
                    ),
                    GestureDetector(
                      onTap: _takePhoto,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.camera_alt,
                            size: 36, color: Colors.green),
                      ),
                    ),
                    IconButton(
                      onPressed: _toggleFlash,
                      icon: Icon(
                        _flashOn ? Icons.flash_on : Icons.flash_off,
                        color: _flashOn ? Colors.yellow : Colors.white,
                      ),
                      iconSize: 32,
                    ),
                  ],
                ),
              ),


              // Quick actions section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Quick Actions",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    // Phone + Laptop cards
                    Row(
                      children: [
                        Expanded(
                          child: _QuickActionBox(
                            color: const Color(0xFF10B981),
                            icon: Icons.phone_iphone,
                            title: "Phone Parts",
                            subtitle: "Scan phone components",
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickActionBox(
                            color: const Color(0xFF3B82F6),
                            icon: Icons.laptop,
                            title: "Laptop Parts",
                            subtitle: "Scan laptop components",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    _QuickActionTip(
                      icon: Icons.lightbulb,
                      title: "Pro Tip",
                      subtitle:
                      "Hold steady and ensure good lighting for better results",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 🔹 Phone & Laptop Quick Action Box
class _QuickActionBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionBox({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 0.5),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12), // ✅ rounded rectangle
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Pro Tip Card
class _QuickActionTip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _QuickActionTip({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF10B981).withOpacity(0.15),
              child: Icon(icon, color: Color(0xFF10B981), size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                      const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
