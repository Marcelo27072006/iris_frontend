import 'package:flutter/material.dart';
import '/components/HomePageComponents/desafioCaixa.dart';
import '/components/HomePageComponents/infoPontos.dart';
import '/components/HomePageComponents/premioCaixaHomePage.dart';
import '/components/HomePageComponents/usoCaixa.dart';
import '/page/perfilPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.nome = '',
    this.email = '',
  });

  final String title;
  final String nome;
  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String nomeUsuario;
  late String emailUsuario;
  double tempoDeUsoHoras = 16;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pega os argumentos da rota, se existirem
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      nomeUsuario = args['nome'] ?? widget.nome;
      emailUsuario = args['email'] ?? widget.email;
    } else {
      // Caso não tenha argumentos na rota, usa os do construtor
      nomeUsuario = widget.nome;
      emailUsuario = widget.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Iris",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfileScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD893E3), Color(0xFFE24CD9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Olá, ${nomeUsuario.isNotEmpty ? nomeUsuario[0].toUpperCase() + nomeUsuario.substring(1) : 'Usuário'} ",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(
                          text: "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(220, 214, 214, 214),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email: $emailUsuario",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      InfoPontos(
                        valor: "4.056",
                        legenda: "Pontos dis..",
                        titulo: "Pontos Disponíveis",
                        texto: "Esses são os pontos que você acumulou.",
                      ),
                      InfoPontos(
                        valor: "4.056",
                        legenda: "Pontos dis..",
                        titulo: "Pontos Disponíveis",
                        texto: "Esses são os pontos que você acumulou.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Desafios",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount =
                    constraints.maxWidth < 350
                        ? 1
                        : constraints.maxWidth < 600
                        ? 2
                        : 3;
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    desafioCaixa("Diário", Icons.calendar_today),
                    desafioCaixa("Semanal", Icons.calendar_view_week),
                    desafioCaixa("Mensal", Icons.calendar_month),
                    desafioCaixa("Ranking", Icons.emoji_events),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tempo de uso",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            usoCaixa(),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Prêmios",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  premioCaixa(
                    "Camiseta exclusiva",
                    Icons.emoji_events,
                    "5.000 pontos",
                  ),
                  const SizedBox(height: 10),
                  premioCaixa(
                    "Caneca personalizada",
                    Icons.local_cafe,
                    "2.000 pontos",
                  ),
                  const SizedBox(height: 10),
                  premioCaixa("Adesivos", Icons.sticky_note_2, "1.000 pontos"),
                  const SizedBox(height: 10),
                  premioCaixa("Mais prêmios", Icons.add, "Outras recompensas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
