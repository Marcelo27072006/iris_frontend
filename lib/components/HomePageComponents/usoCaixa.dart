// Suggested code may be subject to a license. Learn more: ~LicenseLog:3597273014.
import 'package:flutter/material.dart';

var tempoDeUsoHoras;

Widget usoCaixa() {
  return Padding(
    // Suggested code may be subject to a license. Learn more: ~LicenseLog:3416726261.
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
            "$tempoDeUsoHoras horas",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: const Text("Ver mais detalhes"),
            ),
          ),
        ],
      ),
    ),
  );
}
