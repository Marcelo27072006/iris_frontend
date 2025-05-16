// // import 'package:flutter/material.dart';
// // // import 'page/login_page.dart';
// // // import 'page/SignUpPage.dart';
// // import 'page/login_teste.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(debugShowCheckedModeBanner: false,
// //     home: login_teste());
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'page/testes/login_teste.dart';
// import 'page/testes/home_page.dart'; // MyHomePage
// import 'page/testes/SignUpPage_test.dart'; // SignUpPage

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/login',
//       onGenerateRoute: (settings) {
//         // Rota para home recebendo argumentos
//         if (settings.name == '/home') {
//           final args = settings.arguments as Map<String, dynamic>?;

//           return MaterialPageRoute(
//             builder: (context) => MyHomePage(
//               title: 'Página Inicial',
//               nome: args?['nome'] ?? 'Usuário',
//               email: args?['email'] ?? '',
//             ),
//           );
//         }

//         // Rotas padrão
//         switch (settings.name) {
//           case '/login':
//             return MaterialPageRoute(builder: (_) => const login_teste());
//           case '/signup':
//             return MaterialPageRoute(builder: (_) => const SignUpPage());
//           default:
//             return MaterialPageRoute(builder: (_) => const login_teste());
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'page/testes/login_teste.dart';
import 'page/testes/home_page.dart'; // MyHomePage
import 'page/testes/SignUpPage_test.dart'; // SignUpPage
import 'page/routes/splash_screen.dart'; // SplashScreen

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
            return MaterialPageRoute(builder: (_) => const login_teste());

          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignUpPage());

          case '/home':
            final args = settings.arguments as Map<String, dynamic>?;

            return MaterialPageRoute(
              builder:
                  (_) => MyHomePage(
                    title: 'Página Inicial',
                    nome: args?['nome'] ?? 'Usuário',
                    email: args?['email'] ?? '',
                  ),
            );

          default:
            // Rota fallback: redireciona para login se rota não reconhecida
            return MaterialPageRoute(builder: (_) => const login_teste());
        }
      },
    );
  }
}
