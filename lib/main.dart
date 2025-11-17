import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_notes_app/auth_gate.dart';

const supabaseUrl = 'https://pfzsmyvvneyejtulcdbs.supabase.co';
const supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBmenNteXZ2bmV5ZWp0dWxjZGJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMzOTIyMjcsImV4cCI6MjA3ODk2ODIyN30.1d-086LcKbJb4cZ_vxGaPTAgY197ZV-eWQCMhCxpAiY';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase Notes',
      theme: ThemeData(useMaterial3: true),
      home: AuthGate(),
    );
  }
}
