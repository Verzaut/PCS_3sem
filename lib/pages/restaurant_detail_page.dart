import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_critic/models/restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;
  final Function(Restaurant) onSave;

  const RestaurantDetailPage({
    super.key,
    required this.restaurant,
    required this.onSave,
  });

  @override
  State<RestaurantDetailPage> createState() => RestaurantDetailPageState();
}

class RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Restaurant _restaurant;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  double _rating = 0.0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _restaurant = widget.restaurant;
    _nameController.text = _restaurant.name;
    _descriptionController.text = _restaurant.description;
    _addressController.text = _restaurant.address;
    _cuisineController.text = _restaurant.cuisineType;
    _rating = _restaurant.rating;
    _selectedDate = _restaurant.visitDate;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _restaurant.imagePaths.add(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при выборе изображения: $e')),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _restaurant.imagePaths.add(photo.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка при съемке фото: $e')));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _restaurant.imagePaths.removeAt(index);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveRestaurant() {
    final updatedRestaurant = Restaurant(
      id: _restaurant.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      rating: _rating,
      imagePaths: _restaurant.imagePaths,
      visitDate: _selectedDate,
      address: _addressController.text.trim(),
      cuisineType: _cuisineController.text.trim(),
    );

    if (updatedRestaurant.name.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите название ресторана')));
      return;
    }

    widget.onSave(updatedRestaurant);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name.isEmpty ? 'Новый ресторан' : 'Редактировать',
        ),
        actions: [
          IconButton(
            onPressed: _saveRestaurant,
            icon: const Icon(Icons.save),
            tooltip: 'Сохранить',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Название ресторана*',
                prefixIcon: const Icon(Icons.restaurant),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _cuisineController,
              decoration: InputDecoration(
                labelText: 'Тип кухни',
                prefixIcon: const Icon(Icons.kitchen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Адрес',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Дата посещения',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Рейтинг',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _rating = (index + 1).toDouble();
                            });
                          },
                          icon: Icon(
                            index < _rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 40,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        '${_rating.toStringAsFixed(1)} / 5.0',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              maxLength: 500,
            ),
            const SizedBox(height: 24),

            Text(
              'Фотографии',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Из галереи'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Сделать фото'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_restaurant.imagePaths.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: _restaurant.imagePaths.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_restaurant.imagePaths[index]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.photo, size: 60, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                        'Нет фотографий',
                        style: TextStyle(color: Colors.grey),
                      ),
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
