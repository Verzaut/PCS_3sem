import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'screens/create_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MadShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: const SplashLogoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashLogoScreen extends StatelessWidget {
  const SplashLogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Устанавливаем светлый статус-бар для сплеш-экрана
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Восстанавливаем темный статус-бар при переходе
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateAccountScreen(),
              ),
            );
          },
          child: SvgPicture.asset(
            'lib/assets/images/logo.svg',
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}
