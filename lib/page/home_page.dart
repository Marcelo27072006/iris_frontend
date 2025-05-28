import 'package:flutter/material.dart';
import '/components/HomePageComponents/desafioCaixa.dart';
import '/components/HomePageComponents/infoPontos.dart';
import '/components/HomePageComponents/premioCaixaHomePage.dart';
import '/components/HomePageComponents/usoCaixa.dart';
import '/page/UserProfilePage.dart';
import '/components/HomePageComponents/faixarosa.dart';
import '/page/temporizador.dart';
import 'dart:async';

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

  int tempoDeUsoSegundos = 0;
  Timer? _timer;
  bool estaRodando = true;

  @override
  void initState() {
    super.initState();
    nomeUsuario = widget.nome;
    emailUsuario = widget.email;
    iniciarTemporizador();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        nomeUsuario = args['nome'] ?? widget.nome;
        emailUsuario = args['email'] ?? widget.email;
      });
    }
  }

  void iniciarTemporizador() {
    if (_timer == null || !_timer!.isActive) {
      estaRodando = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (estaRodando) {
          setState(() {
            tempoDeUsoSegundos++;
          });
        }
      });
    } else {
      // Se o temporizador já está rodando, não faz nada
      setState(() {
        estaRodando = true;
      });
      return;
    }
  }

  void pausarTemporizador() {
    setState(() {
      estaRodando = false;
    });
  }

  void resetarTemporizador() {
    setState(() {
      tempoDeUsoSegundos = 0;
      estaRodando = false;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> abrirTemporizador() async {
    final segundosRetornados = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder:
            (context) => TemporizadorPage(
              nomeUsuario: nomeUsuario,
              emailUsuario: emailUsuario,
              tempoSegundos: tempoDeUsoSegundos,
              estaRodando: estaRodando,
              iniciar: iniciarTemporizador,
              pausar: pausarTemporizador,
              resetar: resetarTemporizador,
            ),
      ),
    );

    if (segundosRetornados != null) {
      setState(() {
        tempoDeUsoSegundos = segundosRetornados;
      });
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
                          builder: (context) => const UserProfilePage(),
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

            Faixarosa(nomeUsuario: nomeUsuario, emailUsuario: emailUsuario),

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
            usoCaixa(
              context,
              nomeUsuario,
              emailUsuario,
              tempoDeUsoSegundos,
              estaRodando,
              iniciarTemporizador,
              pausarTemporizador,
              resetarTemporizador,
              abrirTemporizador,
            ),
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
