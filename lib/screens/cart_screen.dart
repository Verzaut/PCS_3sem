import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String description;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
  });

  double get totalPrice => price * quantity;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: 'Футболка Basic',
      description: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      quantity: 2,
      imageUrl: 'lib/assets/images/dress1.png',
    ),
    CartItem(
      id: '2',
      name: 'Футболка Premium',
      description: 'Lorem ipsum dolor sit amet consectetur',
      price: 17.00,
      quantity: 1,
      imageUrl: 'lib/assets/images/dress2.png',
    ),
  ];

  double get _totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _removeItem(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Товар удален из корзины')));
  }

  void _checkout() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Корзина пуста')));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Оформление заказа'),
        content: Text('Общая сумма: \$${_totalPrice.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showOrderConfirmation();
            },
            child: const Text('Подтвердить'),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation() {
    setState(() {
      _cartItems.clear();
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Заказ подтвержден!'),
        content: const Text('Спасибо за ваш заказ. Мы свяжемся с вами скоро.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cart',
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
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(_cartItems[index], index);
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'Корзина пуста',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Добавьте товары из каталога',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.shopping_bag, color: Colors.grey[400]);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Новый счетчик товаров
            _buildQuantityCounter(item, index),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _removeItem(index),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityCounter(CartItem item, int index) {
    return Container(
      width: 109,
      height: 30,
      child: Stack(
        children: [
          // Фон счетчика (синий прямоугольник)
          Positioned(
            left: 36,
            child: Container(
              width: 37,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EBFC),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Кнопка минус (левая круглая кнопка)
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () => _decrementQuantity(index),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF004BFE), width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.remove, size: 16, color: Color(0xFF004CFF)),
                ),
              ),
            ),
          ),

          // Кнопка плюс (правая круглая кнопка)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () => _incrementQuantity(index),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF004BFE), width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 16, color: Color(0xFF004CFF)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total сумма
          Row(
            children: [
              const Text(
                'Total ',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Кнопка Checkout
          Container(
            width: 128,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF004CFF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: TextButton(
              onPressed: _checkout,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
