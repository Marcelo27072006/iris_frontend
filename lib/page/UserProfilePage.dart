import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/UserProfilePageComponents/info_container.dart';

class Usuario {
  final String name;
  final String email;
  final String plano;

  Usuario({required this.name, required this.email, required this.plano});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      name: json['name'],
      email: json['email'],
      plano: json['plano'],
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? token;
  Usuario? usuario;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToken().then((_) => _loadUserData());
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    print('Carregando token do SharedPreferences... $prefs');
    final savedToken = prefs.getString('token');
    print('Token carregado: $savedToken');
    setState(() {
      token = savedToken;
    });
  }

  Future<void> _loadUserData() async {
    if (token == null) {
      print("Token está nulo, não é possível buscar os dados do usuário.");
      setState(() => isLoading = false);
      return;
    }

    final url = Uri.parse("http://192.168.221.62:3000/auth/perfil");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = Usuario.fromJson(jsonDecode(response.body));
        setState(() {
          usuario = data;
          isLoading = false;
        });
      } else {
        print(
          "Erro ao buscar perfil: ${response.statusCode} - ${response.body}",
        );
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Erro inesperado: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (context.mounted) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/auth/login', (route) => false);
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    if (token == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Token não encontrado.")));
      return;
    }

    final url = Uri.parse("http://192.168.221.62:3000/auth/delete");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/auth/login', (route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao deletar conta: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro inesperado: $e")));
    }
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmar exclusão"),
          content: const Text(
            "Tem certeza que deseja deletar sua conta? Esta ação não pode ser desfeita.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE24CD9),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _deleteAccount(context);
              },
              child: const Text("Deletar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Perfil do Usuário",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : usuario == null
              ? const Center(child: Text("Erro ao carregar dados do usuário."))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://parawebnews.com/wp-content/uploads/2023/12/opopopop.jpg",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      usuario!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      usuario!.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFD893E3),
                      height: 40,
                    ),
                    InfoContainer(icon: Icons.person, label: usuario!.name),
                    InfoContainer(icon: Icons.email, label: usuario!.email),
                    InfoContainer(icon: Icons.star, label: usuario!.plano),
                    const InfoContainer(
                      icon: Icons.favorite,
                      label: 'Nome do(a) cônjuge',
                    ),
                    const InfoContainer(icon: Icons.lock, label: '*********'),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE24CD9),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Sair"),
                    ),
                    const SizedBox(height: 25),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE24CD9)),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _confirmDeleteAccount(context),
                      icon: const Icon(Icons.delete, color: Color(0xFFE24CD9)),
                      label: const Text(
                        "Deletar Conta",
                        style: TextStyle(color: Color(0xFFE24CD9)),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
