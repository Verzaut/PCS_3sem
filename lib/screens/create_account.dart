import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
              'lib/assets/images/background_create.svg',
              fit: BoxFit.cover,
            ),

            // Контент поверх фона
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // Заголовок Create Account - позиция x: 30, y: 122
                    Positioned(
                      left: 30,
                      top: 122,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 54,
                              height: 1.0, // line height
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 54,
                              height: 1.0, // line height
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Поля ввода - позиция x: 20, y: 406
                    Positioned(
                      left: 20,
                      top: 406,
                      right: 20,
                      child: Column(
                        children: [
                          // Поле Email
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextField(
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Поле Password
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextField(
                              obscureText: true,
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Поле Your number
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(27.5),
                            ),
                            child: TextField(
                              style: TextStyle(fontFamily: 'Poppins'),
                              decoration: InputDecoration(
                                labelText: 'Your number',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Кнопка Done - позиция x: 20, y: 634
                    Positioned(
                      left: 20,
                      top: 634,
                      right: 20,
                      child: SizedBox(
                        width: double.infinity,
                        height: 61,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
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
                            'Done',
                            style: TextStyle(
                              fontFamily:
                                  'NunitoSans', // Добавлен шрифт Nunito Sans
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
