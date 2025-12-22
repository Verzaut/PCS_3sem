import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:restaurant_critic/pages/home_page.dart';
import 'package:restaurant_critic/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yfltcbqjxutxhwqnlvkw.supabase.co',
    anonKey: 'sb_publishable_RGG9KBWxFwOYPfdjypn4sw_KLTjb3pn',
  );

  runApp(const RestaurantCriticApp());
}

class RestaurantCriticApp extends StatelessWidget {
  const RestaurantCriticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ресторанный критик',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final session = Supabase.instance.client.auth.currentSession;
      setState(() {
        _isAuthenticated = session != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.deepOrange),
        ),
      );
    }

    return _isAuthenticated ? const HomePage() : const LoginPage();
  }
}
