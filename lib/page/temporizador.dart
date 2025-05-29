import 'package:flutter/material.dart';
import '/components/HomePageComponents/faixarosa.dart';
import 'dart:async';

class TemporizadorPage extends StatefulWidget {
  final String nomeUsuario;
  final String emailUsuario;
  final int tempoSegundos;
  final bool estaRodando;
  final VoidCallback iniciar;
  final VoidCallback pausar;
  final VoidCallback resetar;

  const TemporizadorPage({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
    required this.tempoSegundos,
    required this.estaRodando,
    required this.iniciar,
    required this.pausar,
    required this.resetar,
  });

  @override
  State<TemporizadorPage> createState() => _TemporizadorPageState();
}
class _TemporizadorPageState extends State<TemporizadorPage> {
  late int segundos;
  Timer? _timer;
  bool _estaRodando = true;

  @override
  void initState() {
    super.initState();
    segundos = widget.tempoSegundos;
    iniciarTimer();
  }

  void iniciarTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_estaRodando) {
        setState(() {
          segundos++;
        });
      }
    });
  }

  void pausarOuRetomar() {
    setState(() {
      _estaRodando = !_estaRodando;
    });
  }

  void resetarTempo() {
    setState(() {
      segundos = 0;
      _estaRodando = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatarTempo(int segundos) {
    final horas = (segundos ~/ 3600).toString().padLeft(2, '0');
    final minutos = ((segundos % 3600) ~/ 60).toString().padLeft(2, '0');
    final segs = (segundos % 60).toString().padLeft(2, '0');
    return "$horas:$minutos:$segs";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, segundos); // Retorna o tempo atualizado
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Temporizador",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, segundos); // Retorna o tempo
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Faixarosa(
                nomeUsuario: widget.nomeUsuario,
                emailUsuario: widget.emailUsuario,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F2FB),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.timer_outlined,
                            color: Color(0xFFE24CD9),
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Tempo de Uso",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        formatarTempo(segundos),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: pausarOuRetomar,
                            icon: Icon(
                              _estaRodando
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            label: Text(
                              _estaRodando ? "Pausar" : "Retomar",
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: resetarTempo,
                            icon: const Icon(Icons.refresh),
                            label: const Text("Resetar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              foregroundColor: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    DashboardCard(
                      title: "Tempo no App",
                      value: formatarTempo(segundos),
                      description: "Tempo total que você passou no aplicativo.",
                    ),
                    const SizedBox(height: 20),
                    DashboardCard(
                      title: "Tempo Focado",
                      value: formatarTempo((segundos * 0.6).toInt()),
                      description:
                          "Tempo que você passou focado em atividades sem distrações.",
                    ),
                    const SizedBox(height: 20),
                    DashboardCard(
                      title: "Atividades em Grupo",
                      value: formatarTempo((segundos * 0.3).toInt()),
                      description:
                          "Tempo dedicado a atividades feitas em casal ou em grupo.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD893E3), Color(0xFFE24CD9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
