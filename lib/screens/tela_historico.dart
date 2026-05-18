import 'package:flutter/material.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0e15),
      appBar: AppBar(
        title: const Text('Histórico de Partidas', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff161722),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estatísticas Gerais',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _construirDadoEstatistica('Partidas', '0'),
                _construirDadoEstatistica('Gols', '0'),
                _construirDadoEstatistica('Artilheiro', '-'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Últimos Rachas',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Nenhuma partida registrada ainda.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirDadoEstatistica(String rotulo, String valor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff161722),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(rotulo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(color: Color(0xffa147ff), fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
