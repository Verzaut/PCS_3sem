import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Фон на весь экран
            SvgPicture.asset(
              'lib/assets/images/background_login.svg',
              fit: BoxFit.cover,
            ),

            // Контент поверх фона
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Заголовок Login - позиция x: 20, y: 438
                  Positioned(
                    left: 20,
                    top: 438,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Подзаголовок с иконкой сердечка - позиция x: 20, y: 503
                  Positioned(
                    left: 20,
                    top: 503,
                    child: Row(
                      children: [
                        Text(
                          'Good to see you back!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(width: 8), // Отступ между текстом и иконкой
                        Icon(
                          Icons.favorite,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          size: 16,
                        ),
                      ],
                    ),
                  ),

                  // Поле ввода Email - позиция x: 20, y: 555
                  Positioned(
                    left: 20,
                    top: 555,
                    right: 20,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          labelStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),

                  // Кнопка Login - позиция x: 20, y: 644
                  Positioned(
                    left: 20,
                    top: 644,
                    right: 20,
                    child: SizedBox(
                      width: double.infinity,
                      height: 61,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Кнопка Cancel - позиция x: 20, y: 719
                  Positioned(
                    left: 20,
                    top: 719,
                    right: 20,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
