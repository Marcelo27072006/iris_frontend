import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final String userName = 'Lucas Oliveira';
  final String userEmail = 'lucas.oliveira@email.com';
  final String userPhone = '(11) 99999-8888';
  final String partnerName = 'Mariana Silva';
  final String avatarUrl =
      'https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80';

  void _onEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Função Editar Perfil ainda não implementada')),
    );
  }

  void _onDeleteProfile() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Perfil'),
        content: const Text(
            'Tem certeza que deseja deletar o seu perfil? Esta ação não poderá ser desfeita.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Deletar')),
        ],
      ),
    );

    if (confirmed == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil deletado. Função backend não implementada.')),
      );
    }
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A687E),
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xFF506772),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Main container max width 340px equivalent, padding and shadow similar to CSS
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        backgroundColor: const Color(0xFF5588A3),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 340,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  offset: Offset(0, 20),
                  blurRadius: 40,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color(0xFF5588A3),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F5061),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    children: [
                      _infoTile('Nome completo:', userName),
                      Divider(color: Colors.grey.shade200, height: 1),
                      _infoTile('Email:', userEmail),
                      Divider(color: Colors.grey.shade200, height: 1),
                      _infoTile('Telefone:', userPhone),
                      Divider(color: Colors.grey.shade200, height: 1),
                      _infoTile('Parceira:', partnerName),
                      Divider(color: Colors.grey.shade200, height: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onEditProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5588A3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shadowColor: Colors.black26,
                          elevation: 6,
                        ),
                        child: const Text(
                          'Editar Perfil',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onDeleteProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD54C4C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shadowColor: Colors.black26,
                          elevation: 6,
                        ),
                        child: const Text(
                          'Deletar Perfil',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}