import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

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
              'lib/assets/images/background_password.svg',
              fit: BoxFit.cover,
            ),

            // Контент поверх фона
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Заголовок Hello! - позиция x: 148, y: 282
                  Positioned(
                    left: 148,
                    top: 282,
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Подзаголовок - позиция x: 104, y: 348
                  Positioned(
                    left: 104,
                    top: 348,
                    child: Text(
                      'Type your password',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),

                  // Поле Password - позиция x: 20, y: 509
                  Positioned(
                    left: 20,
                    top: 509,
                    right: 20,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          labelStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),

                  // Кнопка Start - позиция x: 20, y: 644
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
                              builder: (context) => const HomeScreen(),
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
                          'Start',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Кнопка Cancel - позиция x: 166, y: 719
                  Positioned(
                    left: 166,
                    top: 719,
                    child: SizedBox(
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
