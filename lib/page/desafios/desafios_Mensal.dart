import 'package:flutter/material.dart';
import '/components/HomePageComponents/infoPontos.dart';
import '/components/DesafiosComponents/desafioCard.dart';

class desafios_Mensal extends StatefulWidget {
  const desafios_Mensal({super.key});

  @override
  State<desafios_Mensal> createState() => _desafios_MensalState();
}

class _desafios_MensalState extends State<desafios_Mensal> {
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
                  "Desafios do Mês:",
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
              "ir ao cinema juntos",
              "escolham um filme, aproveitem a experiência e curtam a companhia um outro. o importante é o momento a dois!",
              Icons.movie,
              50,
            ),
            premioCaixaDesaifos(
              "Fazer um piquenique",
              "preparem um lanche juntos e aproveitem o ar livre. um momento simples, mas cheio de coneção",
              Icons.park,
              200,
            ),
            premioCaixaDesaifos(
              "Tire uma foto juntos",
              "sejam fotógrafos e modelos! usem a criatividade para tirar fotos divertidas e criativas, criando lenbranças únicas",
              Icons.camera_alt,
              100,
            ),
          ],
        ),
      ),
    );
  }
}
