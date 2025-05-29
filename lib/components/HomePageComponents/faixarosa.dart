import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/components/HomePageComponents/infoPontos.dart';

class Faixarosa extends StatefulWidget {
  final String nomeUsuario;
  final String emailUsuario;

  const Faixarosa({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
  });

  @override
  State<Faixarosa> createState() => _FaixarosaState();
}

class _FaixarosaState extends State<Faixarosa> {
  double pontosAtuais = 0;
  double pontosDiario = 0;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    buscarPontosDoUsuario();
  }

  Future<void> buscarPontosDoUsuario() async {
    final uri = Uri.parse(
      'http://192.168.221.62:3000/user/email/${widget.emailUsuario}',
    ); // substitua pelo seu IP/porta

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);
        setState(() {
          pontosAtuais = double.tryParse(dados['pontosAtuais'].toString()) ?? 0;
          pontosDiario = double.tryParse(dados['pontosDiario'].toString()) ?? 0;
          carregando = false;
        });
      } else {
        print('Erro ao buscar pontos: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar pontos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome =
        widget.nomeUsuario.isNotEmpty
            ? widget.nomeUsuario[0].toUpperCase() +
                widget.nomeUsuario.substring(1)
            : 'Usuário';

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
          Text(
            "Olá, $nome",
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Email: ${widget.emailUsuario}",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 30),
          carregando
              ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoPontos(
                    valor: pontosAtuais.toStringAsFixed(0),
                    legenda: "Pontos at...",
                    titulo: "Pontos Atuais",
                    texto: "Esses são os pontos disponíveis no momento.",
                  ),
                  InfoPontos(
                    valor: pontosDiario.toStringAsFixed(0),
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
