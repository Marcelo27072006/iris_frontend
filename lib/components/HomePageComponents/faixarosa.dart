import 'package:flutter/material.dart';
import '/components/HomePageComponents/infoPontos.dart';

class Faixarosa extends StatelessWidget {
  final String nomeUsuario;
  final String emailUsuario;

  const Faixarosa({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD893E3), Color(0xFFE24CD9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
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
                valor: "500",
                legenda: "Pontos diá..",
                titulo: "Pontos Diários",
                texto: "Esses são os pontos que você ganha diariamente.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
