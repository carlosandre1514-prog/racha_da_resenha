import 'package:flutter/material.dart';

class TelaJogadores extends StatefulWidget {
  const TelaJogadores({super.key});

  @override
  State<TelaJogadores> createState() => _TelaJogadoresState();
}

class _TelaJogadoresState extends State<TelaJogadores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0e15),
      appBar: AppBar(
        title: const Text('Jogadores do Racha', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff161722),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xffa147ff)),
            onPressed: () {
              // Botão para adicionar jogador futuramente
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Nenhum jogador cadastrado.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
