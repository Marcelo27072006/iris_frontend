import 'package:flutter/material.dart';

class MaisPremiosPage extends StatelessWidget {
  const MaisPremiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mais Prêmios")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("Aqui você verá mais prêmios ou desafios extras!"),
          // Adicione widgets como ListTile, Cards, etc. para exibir os prêmios.
        ],
      ),
    );
  }
}
