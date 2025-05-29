import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Map<String, dynamic>> rankingList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRanking();
  }

  Future<void> fetchRanking() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.221.62:3000/ranking'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          rankingList = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar ranking: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar ranking: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar ranking: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.1),
                    Colors.transparent,
                    Colors.purpleAccent.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Ranking",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : rankingList.length < 3
                    ? Center(
                      child: Text('Não há dados suficientes para o ranking.'),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PlayerWidget(
                          medalEmoji: "2",
                          name: rankingList[1]['name'],
                          points: rankingList[1]['points'],
                          circleColor: Color(
                            int.parse(
                              rankingList[1]['color'].replaceFirst('#', '0xFF'),
                            ),
                          ),
                          size: 70,
                          medalSize: 20,
                          circleColorRanking: Colors.grey,
                        ),
                        const SizedBox(width: 20),
                        PlayerWidget(
                          medalEmoji: "1",
                          name: rankingList[0]['name'],
                          points: rankingList[0]['points'],
                          circleColor: Color(
                            int.parse(
                              rankingList[0]['color'].replaceFirst('#', '0xFF'),
                            ),
                          ),
                          size: 100,
                          medalSize: 30,
                          circleColorRanking: Colors.amber,
                        ),
                        const SizedBox(width: 20),
                        PlayerWidget(
                          medalEmoji: "3",
                          name: rankingList[2]['name'],
                          points: rankingList[2]['points'],
                          circleColor: Color(
                            int.parse(
                              rankingList[2]['color'].replaceFirst('#', '0xFF'),
                            ),
                          ),
                          size: 70,
                          medalSize: 20,
                          circleColorRanking: Color.fromARGB(169, 238, 135, 39),
                        ),
                      ],
                    ),
                const SizedBox(height: 40),
                isLoading
                    ? SizedBox.shrink()
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rankingList.length - 3,
                      itemBuilder: (context, index) {
                        final player = rankingList[index + 3];
                        return RowPlayerWidget(
                          position: player['position'],
                          name: player['name'],
                          points: player['points'],
                          image: null,
                          circleColor: Color(
                            int.parse(
                              player['color'].replaceFirst('#', '0xFF'),
                            ),
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final String medalEmoji;
  final String name;
  final String points;
  final Color circleColor;
  final double size;
  final double medalSize;
  final Color circleColorRanking;

  const PlayerWidget({
    required this.medalEmoji,
    required this.name,
    required this.points,
    required this.circleColor,
    required this.size,
    required this.medalSize,
    required this.circleColorRanking,
    super.key,
  });

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  bool tapped = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tapped = !tapped;
        });
        HapticFeedback.lightImpact();
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: tapped || isHovered ? 1.1 : 1.0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: tapped || isHovered ? 1.0 : 0.85,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: widget.size + 20,
                      height: widget.size + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.circleColor.withOpacity(0.2),
                      ),
                    ),
                    CircleAvatar(
                      radius: widget.size / 2,
                      backgroundColor: widget.circleColor,
                      child: Text(
                        widget.name[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.size / 3,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: widget.medalSize,
                        height: widget.medalSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.circleColorRanking,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            widget.medalEmoji,
                            style: TextStyle(
                              fontSize: widget.medalSize / 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.points,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowPlayerWidget extends StatefulWidget {
  final String position;
  final String name;
  final String points;
  final Image? image;
  final Color circleColor;

  const RowPlayerWidget({
    required this.position,
    required this.name,
    required this.points,
    this.image,
    required this.circleColor,
    super.key,
  });

  @override
  _RowPlayerWidgetState createState() => _RowPlayerWidgetState();
}

class _RowPlayerWidgetState extends State<RowPlayerWidget> {
  bool tapped = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            tapped = !tapped;
          });
          HapticFeedback.lightImpact();
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: tapped || isHovered ? 1.02 : 1.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: tapped || isHovered ? 1.0 : 0.95,
              child: Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      "${widget.position}º",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(width: 16),
                    widget.image ??
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: widget.circleColor,
                          child: Text(
                            widget.name[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          widget.points,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
