import 'package:flutter/material.dart';
import '/components/DesafiosComponents/desafioCard.dart';
import '/components/HomePageComponents/infoPontos.dart';

class DesafiosDiariosPage extends StatefulWidget {
  const DesafiosDiariosPage({super.key});

  @override
  State<DesafiosDiariosPage> createState() => _DesafiosDiariosPageState();
}

class _DesafiosDiariosPageState extends State<DesafiosDiariosPage> {
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  if (Navigator.canPop(context))
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  const Spacer(), // Isso vai empurrar o título para o centro
                  const Text(
                    "Iris",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Container com pontos
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD893E3), Color(0xFFE24CD9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                  "Desafios do dia:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(height: 20),

            premioCaixaDesaifos(
              "Lavar Pratos",
              "Lavar pratos juntos pode ser um momento de conexão. Deixe o celular de lado e aproveite!",
              Icons.cleaning_services,
              10,
            ),
            premioCaixaDesaifos(
              "Fazer uma caminhada",
              "Caminhem juntos, conversem e curtam o momento. O celular pode esperar!",
              Icons.directions_walk,
              100,
            ),
            premioCaixaDesaifos(
              "Tire uma foto juntos",
              "Tirem a foto, depois aproveitem o momento. O melhor registro é a lembrança!",
              Icons.camera_alt,
              50,
            ),
          ],
        ),
      ),
    );
  }

  Widget infoPontos(String valor, String legenda, String titulo, String texto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              valor,
              style: const TextStyle(
                fontSize: 18, // Reduzido
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(titulo),
                        content: Text(texto),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Entendi"),
                          ),
                        ],
                      ),
                );
              },
              child: const Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          legenda,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }
}
