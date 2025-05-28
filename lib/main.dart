import 'package:flutter/material.dart';
import 'page/loginPage.dart';
import 'page/home_page.dart';
import 'page/SignUpPage.dart';
import 'page//splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());

          case '/login':
            return MaterialPageRoute(builder: (_) => const loginPage());

          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignUpPage());

          case '/home':
            final args = settings.arguments as Map<String, dynamic>?;

            return MaterialPageRoute(
              builder:
                  (_) => MyHomePage(
                    title: 'Página Inicial',
                    nome: args?['nome'] ?? '',
                    email: args?['email'] ?? '',
                  ),
            );

          default:
            return MaterialPageRoute(builder: (_) => const loginPage());
        }
      },
    );
  }
}
