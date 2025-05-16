import 'package:flutter/material.dart';

Widget premioCaixaDesaifos(
  String titulo,
  String descricao,
  IconData icone,
  int pontos,
) {
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
          onTap: () {},
          child: AnimatedScale(
            duration: const Duration(milliseconds: 100),
            scale: pressed ? 0.97 : (hovering ? 1.05 : 1.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hovering ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE3E3E3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icone, size: 20, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          descricao,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Custo: $pontos",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
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
