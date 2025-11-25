import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const CameraApp());

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera Demo',
      theme: ThemeData(useMaterial3: true),
      home: const CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _checkPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  Future<void> _getImage(ImageSource source) async {
    await _checkPermissions();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null && mounted) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _saveImage() async {
    if (_image == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final newFile = await _image!.copy(
      '${dir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Сохранено: ${newFile.path}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Работа с камерой')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('Фото не выбрано')
                : Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 40),
            // Горизонтальное расположение круглых кнопок
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(
                  icon: Icons.camera_alt,
                  tooltip: 'Сделать фото',
                  onPressed: () => _getImage(ImageSource.camera),
                ),
                const SizedBox(width: 30),
                _buildCircleButton(
                  icon: Icons.image,
                  tooltip: 'Выбрать из галереи',
                  onPressed: () => _getImage(ImageSource.gallery),
                ),
                const SizedBox(width: 30),
                _buildCircleButton(
                  icon: Icons.save,
                  tooltip: 'Сохранить фото',
                  onPressed: _saveImage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        shape: const CircleBorder(),
        color: Colors.white,
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.blue, size: 28),
          ),
        ),
      ),
    );
  }
}
