import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // SVG иконка сердечка для избранного
  final String favoriteIconSvg = '''
<svg width="23" height="21" viewBox="0 0 23 21" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_29224_483)">
<path d="M11.0105 18.6365C15.8558 15.3147 18.3971 12.2928 19.4392 9.76366C21.3962 5.01291 18.0641 2 14.7778 2C13.3756 2 11.9813 2.54898 11.0105 3.74559C10.0395 2.54873 8.64557 2 7.24308 2C3.95706 2 0.624878 5.01333 2.58168 9.76366C3.62386 12.2928 6.16507 15.3147 11.0105 18.6365ZM11.0105 20.6365C10.6154 20.6365 10.2204 20.5197 9.87959 20.2861C5.13987 17.0367 2.06235 13.7529 0.732516 10.5256C-0.373284 7.84119 -0.224294 5.23099 1.15195 3.17563C2.46355 1.21683 4.79753 0 7.24308 0C8.61323 0 9.91515 0.385814 11.0105 1.09276C12.1058 0.385817 13.4077 0 14.7778 0C17.2236 0 19.5576 1.21678 20.8691 3.17549C22.2453 5.23077 22.3943 7.84102 21.2885 10.5254C19.9586 13.7529 16.881 17.0367 12.1413 20.2861C11.8006 20.5197 11.4055 20.6365 11.0105 20.6365Z" fill="#F0240D"/>
</g>
<defs>
<clipPath id="clip0_29224_483">
<rect width="22.022" height="20.636" fill="white"/>
</clipPath>
</defs>
</svg>
''';

  // Список избранных товаров
  final List<Map<String, dynamic>> favoriteProducts = [
    {
      'id': '1',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress1.png',
    },
    {
      'id': '2',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress2.png',
    },
    {
      'id': '3',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress3.png',
    },
    {
      'id': '4',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress4.png',
    },
  ];

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: favoriteProducts.isEmpty
          ? _buildEmptyFavorites()
          : _buildFavoritesGrid(),
    );
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'Избранное',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Здесь будут ваши избранные товары',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: favoriteProducts.length,
      itemBuilder: (context, index) {
        return _buildFavoriteCard(favoriteProducts[index], index);
      },
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> product, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Картинка товара
              Container(
                height: 140,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(
                            Icons.shopping_bag,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Описание товара
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product['price'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Красное сердечко в левом верхнем углу
          Positioned(
            top: 8,
            left: 8,
            child: GestureDetector(
              onTap: () => _removeFromFavorites(index),
              child: SvgPicture.string(
                favoriteIconSvg,
                width: 23,
                height: 21,
                color: Colors.red, // Всегда красное
              ),
            ),
          ),
          // Иконка пакета отсутствует
        ],
      ),
    );
  }
}
