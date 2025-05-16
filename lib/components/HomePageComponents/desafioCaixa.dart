import 'package:flutter/material.dart';
import '/page/RankingPage.dart';
import '/page/desafios/DesafiosDiarios.dart';
import '/page/desafios/DesafiosSemanais.dart';
import '/page/desafios/desafios_Mensal.dart';

Widget desafioCaixa(String titulo, IconData icone) {
  bool hovering = false;
  bool pressed = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: GestureDetector(
          onTapDown: (_) => setState(() => pressed = true),
          onTapUp: (_) => setState(() => pressed = false),
          onTapCancel: () => setState(() => pressed = false),
          onTap: () {
            if (titulo == "Ranking") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RankingPage()),
              );
            } else if (titulo == "Semanal") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DesafiosSemanaisPage()),
              );
            } else if (titulo == "Diário") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DesafiosDiariosPage()),
              );
            } else if (titulo == "Mensal") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => desafios_Mensal()),
              );
            }
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 100),
            scale: pressed ? 0.97 : (hovering ? 1.05 : 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: hovering ? Colors.grey[200] : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 173, 173, 173),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icone, size: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
