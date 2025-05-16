import 'package:flutter/material.dart';
import '../../components/styleComponents/my_buttom.dart';
import '/components/styleComponents/my_textField.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    print('Botão pressionado');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500), // Limitando a largura
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),

                    // logo
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.asset(
                          'assets/images/iris.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Bem-vindo!
                    Text(
                      'Bem vindo de volta à Iris!',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 25),

                    // Campo de email
                    MyTextfield(
                      Controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: Icon(Icons.email),
                    ),

                    SizedBox(height: 20),

                    // Campo de senha
                    MyTextfield(
                      Controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      obscureText: true,
                    ),

                    SizedBox(height: 10),

                    // Esqueceu a senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Botão de login
                    MyButtom(onTap: signUserIn, hintText: 'Login'),

                    SizedBox(height: 30),

                    // Divisor
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[500],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'ou continuar com',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Botão Google
                    GestureDetector(
                      onTap: () {}, // Você pode adicionar ação depois
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/google_icon.png',
                          height: 50,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Registrar-se
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {}, // Pode colocar navegação para registro
                          child: Text(
                            'Registre-se agora',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 8.0,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
