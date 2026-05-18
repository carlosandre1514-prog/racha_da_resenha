import 'package:flutter/material.dart';
import 'package:racha_da_resenha/services/banco_service.dart';

class TelaJogadores extends StatefulWidget {
  const TelaJogadores({super.key});

  @override
  State<TelaJogadores> createState() => _TelaJogadoresState();
}

class _TelaJogadoresState extends State<TelaJogadores> {
  final BancoService _bancoService = BancoService();
  final TextEditingController _controleNome = TextEditingController();

  void _abrirDialogoAdicionar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff161722),
          title: const Text('Novo Jogador', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _controleNome,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Digite o nome do craque...',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffa147ff))),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controleNome.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffa147ff)),
              onPressed: () async {
                if (_controleNome.text.trim().isNotEmpty) {
                  final novoJogador = Jogador(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    nome: _controleNome.text.trim(),
                  );
                  
                  await _bancoService.salvarJogadorNoBanco(novoJogador);
                  
                  _controleNome.clear();
                  if (mounted) Navigator.pop(context);
                }
              },
              child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _realizarSorteio(List<Jogador> jogadores) {
    if (jogadores.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione pelo menos 2 jogadores para sortear!')),
      );
      return;
    }
    
    final listaEmbaralhada = List<Jogador>.from(jogadores)..shuffle();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff161722),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥 Times Sorteados! 🔥', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Time Colete 🎽', style: TextStyle(color: Color(0xffa147ff), fontWeight: FontWeight.bold)),
                      subtitle: Text(listaEmbaralhada.first.nome, style: const TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      title: const Text('Time Sem Colete 👕', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      subtitle: Text(listaEmbaralhada.last.nome, style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
            icon: const Icon(Icons.add, color: Color(0xffa147ff), size: 28),
            onPressed: () => _abrirDialogoAdicionar(context),
          )
        ],
      ),
      body: StreamBuilder<List<Jogador>>(
        stream: _bancoService.escutarJogadoresDoBanco(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xffa147ff)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum jogador cadastrado.\nToque no + para adicionar!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final listaJogadores = snapshot.data!;

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 80),
                itemCount: listaJogadores.length,
                itemBuilder: (context, index) { // Corrigido de itemKind para itemBuilder ✅
                  final jogador = listaJogadores[index];
                  return Card(
                    color: const Color(0xff161722),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xff222332),
                        child: Icon(Icons.person, color: Color(0xffa147ff)),
                      ),
                      title: Text(jogador.nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffa147ff),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    icon: const Icon(Icons.shuffle, color: Colors.white),
                    label: const Text('SORTEAR TIMES', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    onPressed: () => _realizarSorteio(listaJogadores),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
