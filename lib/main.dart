import 'package:flutter/material.dart';
import 'package:pick_n_pay/features/login/login_screeen.dart';
import 'package:pick_n_pay/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: 'https://vvnvlxcawxptlpdtvxln.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2bnZseGNhd3hwdGxwZHR2eGxuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMjk0ODE0NSwiZXhwIjoyMDQ4NTI0MTQ1fQ.U5QZqx5oXzIY1vICbVZTFmupBPb1F6qh_L7Ech5PoLA',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}
