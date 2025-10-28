import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

// SVG иконки вынесены в глобальные константы
const String homeIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_29315_94)">
<rect opacity="0.01" width="24" height="24" fill="white"/>
<g clip-path="url(#clip1_29315_94)">
<g clip-path="url(#clip2_29315_94)">
<path d="M21.9072 9.23047V20.7021C21.9072 21.2616 21.3724 21.8818 20.4961 21.8818H3.62012C2.74384 21.8818 2.20899 21.2616 2.20898 20.7021V9.23047L12.0576 2.30371L21.9072 9.23047Z" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M8.85693 20.925V10.917H15.2587V20.925" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</g>
</g>
</g>
<defs>
<clipPath id="clip0_29315_94">
<rect width="24" height="24" fill="white"/>
</clipPath>
<clipPath id="clip1_29315_94">
<rect width="21.6982" height="21.8012" fill="white" transform="translate(1.20898 1.08105)"/>
</clipPath>
<clipPath id="clip2_29315_94">
<rect width="21.6982" height="21.8012" fill="white" transform="translate(1.20898 1.08105)"/>
</clipPath>
</defs>
</svg>
''';

const String favoriteIconSvg = '''
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

const String cartIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect opacity="0.01" width="24" height="24" fill="white"/>
<g clip-path="url(#clip0_29224_557)">
<g clip-path="url(#clip1_29224_557)">
<path d="M18.9692 2L22.1274 5.7627V20.7998C22.1274 21.36 21.5821 22 20.6665 22H3.43701C2.52167 21.9998 1.97607 21.3599 1.97607 20.7998V5.7627L5.13428 2H18.9692Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M2.57104 5.3999H21.6366" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M16.3665 9.7998C16.3665 12.2299 14.4348 14.1998 12.0518 14.1998C9.66883 14.1998 7.73706 12.2299 7.73706 9.7998" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</g>
</g>
<defs>
<clipPath id="clip0_29224_557">
<rect width="22.1519" height="21.9999" fill="white" transform="translate(0.976074 1)"/>
</clipPath>
<clipPath id="clip1_29224_557">
<rect width="22.1519" height="21.9999" fill="white" transform="translate(0.976074 1)"/>
</clipPath>
</defs>
</svg>
''';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _HomeContent(), // Контент главного экрана с товарами
    FavoritesScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.string(
                homeIconSvg,
                width: 24,
                height: 24,
                color: _currentIndex == 0 ? Colors.blue : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.string(
                favoriteIconSvg,
                width: 24,
                height: 30,
                color: _currentIndex == 1 ? Colors.blue : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.string(
                cartIconSvg,
                width: 24,
                height: 24,
                color: _currentIndex == 2 ? Colors.blue : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress1.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '2',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress2.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '3',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress3.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '4',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress4.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '9',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress3.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '5',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress1.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '6',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress2.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '7',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress3.png',
      'isFavorite': false,
      'isInCart': false,
    },
    {
      'id': '8',
      'description': 'Lorem ipsum dolor sit amet consectetur',
      'price': 17.00,
      'image': 'lib/assets/images/dress4.png',
      'isFavorite': false,
      'isInCart': false,
    },
  ];

  final TextEditingController _searchController = TextEditingController();

  void _toggleFavorite(int index) {
    setState(() {
      products[index]['isFavorite'] = !products[index]['isFavorite'];
    });
  }

  void _toggleCart(int index) {
    setState(() {
      products[index]['isInCart'] = !products[index]['isInCart'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Shop',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Clothing',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    // Убрана иконка лупы
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Убрана надпись "Clothing"
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
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
          // Иконки поверх картинки
          // Сердце в левом верхнем углу
          Positioned(
            top: 8,
            left: 8,
            child: GestureDetector(
              onTap: () => _toggleFavorite(index),
              child: SvgPicture.string(
                favoriteIconSvg,
                width: 23,
                height: 21,
                color: product['isFavorite'] ? Colors.red : Colors.white,
              ),
            ),
          ),
          // Пакет в левом нижнем углу изображения
          Positioned(
            bottom: 110,
            left: 8,
            child: GestureDetector(
              onTap: () => _toggleCart(index),
              child: SvgPicture.string(
                cartIconSvg,
                width: 24,
                height: 24,
                color: product['isInCart'] ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
