import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_critic/models/restaurant.dart';
import 'restaurant_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    restaurants = [
      Restaurant(
        id: '1',
        name: 'Итальянский уголок',
        description: 'Отличная итальянская кухня с домашней пастой',
        rating: 4.5,
        visitDate: DateTime.now().subtract(const Duration(days: 30)),
        address: 'ул. Итальянская, 15',
        cuisineType: 'Итальянская',
        imagePaths: [],
      ),
      Restaurant(
        id: '2',
        name: 'Суши бар',
        description: 'Свежие суши и роллы от японского шефа',
        rating: 4.2,
        visitDate: DateTime.now().subtract(const Duration(days: 45)),
        address: 'ул. Восточная, 28',
        cuisineType: 'Японская',
        imagePaths: [],
      ),
      Restaurant(
        id: '3',
        name: 'Мясная лавка',
        description: 'Стейки и гриль на открытом огне',
        rating: 4.7,
        visitDate: DateTime.now().subtract(const Duration(days: 60)),
        address: 'пр. Мясников, 42',
        cuisineType: 'Европейская',
        imagePaths: [],
      ),
    ];
  }

  void _addRestaurant() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailPage(
          restaurant: Restaurant(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: '',
            description: '',
            visitDate: DateTime.now(),
          ),
          onSave: (restaurant) {
            setState(() {
              restaurants.insert(0, restaurant);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ресторан добавлен'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.deepOrange,
              ),
            );
          },
        ),
      ),
    );
  }

  void _editRestaurant(Restaurant restaurant) {
    final index = restaurants.indexOf(restaurant);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailPage(
          restaurant: restaurant,
          onSave: (updatedRestaurant) {
            setState(() {
              restaurants[index] = updatedRestaurant;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Изменения сохранены'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.deepOrange,
              ),
            );
          },
        ),
      ),
    );
  }

  void _viewImage(Restaurant restaurant, int imageIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImageViewerScreen(restaurant: restaurant, initialIndex: imageIndex),
      ),
    );
  }

  void _deleteRestaurant(Restaurant restaurant) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить ресторан'),
        content: Text(
          'Вы уверены, что хотите удалить "${restaurant.name}"?',
          style: const TextStyle(color: Colors.grey),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ОТМЕНА'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('УДАЛИТЬ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        restaurants.remove(restaurant);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ресторан удален'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    final hasImages = restaurant.imagePaths.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: InkWell(
        onTap: () => _editRestaurant(restaurant),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: hasImages ? () => _viewImage(restaurant, 0) : null,
                child: Container(
                  width: 88,
                  height: 88,
                  margin: const EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      _buildRestaurantImage(restaurant),
                      if (hasImages)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(128),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.zoom_in,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                height: 1.1,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(8, -8),
                            child: IconButton(
                              onPressed: () => _deleteRestaurant(restaurant),
                              icon: const Icon(
                                Icons.more_vert,
                                size: 20,
                                color: Colors.grey,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        restaurant.cuisineType,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          height: 1.1,
                        ),
                      ),
                      Container(
                        height: 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildRatingStars(restaurant.rating),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.calendar_today,
                              size: 11,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${restaurant.visitDate.day}.${restaurant.visitDate.month}.${restaurant.visitDate.year}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                height: 1.0,
                              ),
                            ),
                            if (hasImages) ...[
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.photo,
                                size: 11,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${restaurant.imagePaths.length}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w500,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantImage(Restaurant restaurant) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: restaurant.imagePaths.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(restaurant.imagePaths.first),
                fit: BoxFit.cover,
                width: 88,
                height: 88,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage(restaurant);
                },
              ),
            )
          : _buildPlaceholderImage(restaurant),
    );
  }

  Widget _buildPlaceholderImage(Restaurant restaurant) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: Colors.deepOrange.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          restaurant.name.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return SizedBox(
      height: 14,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Icon(
              index < rating.floor()
                  ? Icons.star
                  : (index < rating ? Icons.star_half : Icons.star_border),
              size: 11,
              color: Colors.amber,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ресторанный критик',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Все рестораны (${restaurants.length})',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Сортировка',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: restaurants.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.restaurant_menu,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Нет добавленных ресторанов',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Добавьте первый ресторан для оценки',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return _buildRestaurantCard(restaurants[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: _addRestaurant,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          icon: const Icon(Icons.add, size: 28),
          label: const Text(
            'Добавить ресторан',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          extendedPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выйти'),
        content: const Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ОТМЕНА'),
          ),
          TextButton(
            onPressed: () {
              // Создаем новую навигацию чтобы сбросить стек
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPageWrapper(),
                ),
                (route) => false, // Удаляем все предыдущие маршруты
              );
            },
            child: const Text('ВЫЙТИ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Обертка для страницы входа
class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginPageContent());
  }
}

// Содержимое страницы входа
class LoginPageContent extends StatefulWidget {
  const LoginPageContent({super.key});

  @override
  State<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  final _emailController = TextEditingController(text: 'user@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPageWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ресторанный критик',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите в свой аккаунт',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Запомнить меня и забыли пароль
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Text(
                        'Запомнить меня',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Функция восстановления пароля в разработке',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Войти'),
              ),
              const SizedBox(height: 24),

              // Разделитель
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Или',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),

              // Кнопка быстрой регистрации
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _navigateToRegister(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.deepOrange),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Создать аккаунт',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Тестовый аккаунт
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Тестовый аккаунт',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: user@example.com\nПароль: password123',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
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

// Обертка для страницы регистрации
class RegisterPageWrapper extends StatefulWidget {
  const RegisterPageWrapper({super.key});

  @override
  State<RegisterPageWrapper> createState() => _RegisterPageWrapperState();
}

class _RegisterPageWrapperState extends State<RegisterPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterPageContent(
        onBackToLogin: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

// Содержимое страницы регистрации
class RegisterPageContent extends StatefulWidget {
  final VoidCallback onBackToLogin;

  const RegisterPageContent({super.key, required this.onBackToLogin});

  @override
  State<RegisterPageContent> createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<RegisterPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Пока просто показываем сообщение об успехе
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Регистрация успешна! Теперь вы можете войти.'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Войти',
          textColor: Colors.white,
          onPressed: () {
            widget.onBackToLogin();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Регистрация',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBackToLogin,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Заголовок
              const Text(
                'Создайте аккаунт',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Присоединяйтесь к сообществу ресторанных критиков',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),

              // Имя
              Text(
                'Имя',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Введите ваше имя',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите ваше имя';
                  }
                  if (value.trim().length < 2) {
                    return 'Имя должно содержать минимум 2 символа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Введите корректный email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Пароль
              Text(
                'Пароль',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Введите пароль',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите пароль';
                  }
                  if (value.length < 6) {
                    return 'Пароль должен содержать минимум 6 символов';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Подтверждение пароля
              Text(
                'Подтверждение пароля',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Повторите пароль',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Подтвердите пароль';
                  }
                  if (value != _passwordController.text) {
                    return 'Пароли не совпадают';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Кнопка регистрации
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Ссылка на вход
              Center(
                child: GestureDetector(
                  onTap: widget.onBackToLogin,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      children: [
                        const TextSpan(text: 'Уже есть аккаунт? '),
                        TextSpan(
                          text: 'Войти',
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageViewerScreen extends StatefulWidget {
  final Restaurant restaurant;
  final int initialIndex;

  const ImageViewerScreen({
    super.key,
    required this.restaurant,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _scale = 1.0;
      _previousScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.restaurant.imagePaths.length}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.restaurant.imagePaths.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onScaleStart: (details) {
                    _previousScale = _scale;
                  },
                  onScaleUpdate: (details) {
                    setState(() {
                      _scale = (_previousScale * details.scale).clamp(0.5, 4.0);
                    });
                  },
                  onDoubleTap: () {
                    setState(() {
                      _scale = _scale == 1.0 ? 2.0 : 1.0;
                    });
                  },
                  child: Transform.scale(
                    scale: _scale,
                    child: Center(
                      child: Image.file(
                        File(widget.restaurant.imagePaths[index]),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Не удалось загрузить изображение',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (widget.restaurant.imagePaths.length > 1)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.restaurant.imagePaths.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.deepOrange
                          : Colors.white.withAlpha(128),
                    ),
                  ),
                ),
              ),
            ),

          if (_scale != 1.0)
            Positioned(
              top: 80,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_scale.toStringAsFixed(1)}x',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
