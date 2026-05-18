import 'package:flutter/material.dart';

class TelaConfig extends StatelessWidget {
  const TelaConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0e15),
      appBar: AppBar(
        title: const Text('Configurações', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff161722),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.storage, color: Color(0xffa147ff)),
            title: const Text('Banco de Dados Supabase', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Conectado com sucesso', style: TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
