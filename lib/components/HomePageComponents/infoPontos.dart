import 'package:flutter/material.dart';

class InfoPontos extends StatelessWidget {
  final String valor;
  final String legenda;
  final String titulo;
  final String texto;

  const InfoPontos({
    Key? key,
    required this.valor,
    required this.legenda,
    required this.titulo,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              valor,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
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
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}
