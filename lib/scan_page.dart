
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';
import 'category_page.dart';

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
    try {
      final cams = await availableCameras();
      // try to pick back camera (fallback to first)
      final back = cams.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cams.isNotEmpty ? cams.first : throw "No camera found",
      );
      _controller = CameraController(
        back,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
      // set initial flash off
      await _controller!.setFlashMode(FlashMode.off);
      setState(() => _isCameraReady = true);
    } catch (e) {
      debugPrint("Camera init error: $e");
      // keep UI responsive — show error via snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Camera unavailable: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleFlash() async {
    if (_controller == null) return;
    try {
      _flashOn = !_flashOn;
      await _controller!.setFlashMode(_flashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_flashOn ? "Flash enabled" : "Flash disabled"),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint("Flash error: $e");
    }
  }

  void _openGallery() {
    // TODO: Replace with actual image picker implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Open gallery (to implement)")),
    );
  }

  void _takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera not ready")),
      );
      return;
    }
    try {
      final file = await _controller!.takePicture();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Photo saved at ${file.path}")),
      );
      // TODO: handle file.path (analyze, save to history, etc.)
    } catch (e) {
      debugPrint("Take photo error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to take photo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            // switch to home/tab 0 without losing bottom navbar
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
      body: SafeArea(
        child: SingleChildScrollView(
          // scrollable body
          child: Column(
            children: [
              // Camera section (Hint + Preview + Controls in one stack)
              Center(
                child: Container(
                  width: double.infinity,
                  height: 450,
                  color: Colors.transparent, // ✅ no black background
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ✅ Camera Preview fills background
                      if (_isCameraReady && _controller != null)
                        CameraPreview(_controller!)
                      else
                        const Center(child: CircularProgressIndicator()),

                      // ✅ Top hint floating
                      Positioned(
                        top: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Point camera at device parts",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Green scanning frame in the middle
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF10B981), width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      // ✅ Bottom controls floating
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Gallery button
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                onPressed: _openGallery,
                                icon: const Icon(Icons.photo_library, color: Colors.white),
                              ),
                            ),

                            // Capture button
                            GestureDetector(
                              onTap: _takePhoto,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF10B981),
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                child: const Icon(Icons.camera_alt, size: 36, color: Colors.white),
                              ),
                            ),

                            // Flash button
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                onPressed: _toggleFlash,
                                icon: Icon(
                                  _flashOn ? Icons.flash_on : Icons.flash_off,
                                  color: _flashOn ? Colors.yellow : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quick actions section (white card area)
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickActionBox(
                            color: const Color(0xFF10B981),
                            icon: Icons.phone_iphone,
                            title: "Phone Parts",
                            subtitle: "Scan phone components",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CategoryPage(title: "Phone Parts"),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickActionBox(
                            color: const Color(0xFF3B82F6),
                            icon: Icons.laptop,
                            title: "Laptop Parts",
                            subtitle: "Scan laptop components",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CategoryPage(title: "Laptop Parts"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _QuickActionTip(
                      icon: Icons.lightbulb,
                      title: "Pro Tip",
                      subtitle: "Hold steady and ensure good lighting for better results",
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

// ------------------ Supporting widgets ------------------

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
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25), width: 0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

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
              backgroundColor: const Color(0xFF10B981).withOpacity(0.15),
              child: Icon(icon, color: const Color(0xFF10B981), size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
