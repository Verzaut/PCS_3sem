import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notes_page.dart';

final supabase = Supabase.instance.client;

class AuthGate extends StatefulWidget {
  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      print('Attempting sign in with: $email');

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('✅ Sign in successful! User: ${response.user?.email}');
    } on AuthException catch (e) {
      print('Auth error: ${e.message}');
      setState(() => _errorMessage = 'Error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      setState(() => _errorMessage = 'Unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill all fields');
      return;
    }

    if (password.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      print('Attempting sign up with: $email');

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      print('Sign up response: ${response.user}');
      print('Session: ${response.session}');

      if (response.session != null) {
        print('✅ User created and signed in successfully!');
        // Пользователь сразу вошел в систему
      } else {
        // Если нет сессии, пробуем войти после регистрации
        print('No session after signup, attempting sign in...');
        await _signIn();
      }
    } on AuthException catch (e) {
      print('Auth error: ${e.message}');

      // Если пользователь уже существует, пробуем войти
      if (e.message.toLowerCase().contains('already registered') ||
          e.message.toLowerCase().contains('user already exists')) {
        print('User exists, attempting sign in...');
        await _signIn();
      } else {
        setState(() => _errorMessage = 'Registration error: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e');
      setState(() => _errorMessage = 'Unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Проверяем, есть ли активная сессия
        final session = supabase.auth.currentSession;
        if (session != null) {
          return NotesPage();
        }

        return Scaffold(
          appBar: AppBar(title: Text('Auth')),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password (min 6 characters)',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                if (_errorMessage != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
