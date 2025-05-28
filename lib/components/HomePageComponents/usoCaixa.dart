import 'package:flutter/material.dart';
import '/page/temporizador.dart';
Widget usoCaixa(
  BuildContext context,
  String nomeUsuario,
  String emailUsuario,
  int tempoDeUsoSegundos,
  bool estaRodando,
  VoidCallback iniciar,
  VoidCallback pausar,
  VoidCallback resetar,
  VoidCallback abrirTemporizador,
) {
  String formatarTempo(int segundos) {
    final horas = (segundos ~/ 3600).toString().padLeft(2, '0');
    final minutos = ((segundos % 3600) ~/ 60).toString().padLeft(2, '0');
    final segs = (segundos % 60).toString().padLeft(2, '0');
    return "$horas:$minutos:$segs";
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Você usou o app por:",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            formatarTempo(tempoDeUsoSegundos),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),

          /// Botões de controle direto na Home
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: estaRodando ? pausar : iniciar,
                icon: Icon(
                  estaRodando ? Icons.pause : Icons.play_arrow,
                  color: const Color(0xFFE24CD9),
                ),
                iconSize: 40,
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: resetar,
                icon: const Icon(Icons.refresh, color: Colors.grey),
                iconSize: 35,
              ),
            ],
          ),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: abrirTemporizador,
              child: const Text(
                "Ver mais detalhes",
                style: TextStyle(
                  color: Color(0xFFE24CD9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
