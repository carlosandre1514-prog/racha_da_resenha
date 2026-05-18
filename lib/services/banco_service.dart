import 'package:supabase_flutter/supabase_flutter.dart';

// Modelo do Jogador embutido para evitar erros de import
class Jogador {
  final String id;
  final String nome;

  Jogador({required this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory Jogador.fromMap(Map<String, dynamic> map) {
    return Jogador(
      id: map['id']?.toString() ?? '',
      nome: map['nome']?.toString() ?? '',
    );
  }
}

class BancoService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Salvar jogador no Supabase
  Future<void> salvarJogadorNoBanco(Jogador jogador) async {
    await _supabase.from('jogadores').insert(jogador.toMap());
  }

  // Escutar atualizações de jogadores em tempo real
  Stream<List<Jogador>> escutarJogadoresDoBanco() {
    return _supabase
        .from('jogadores')
        .stream(primaryKey: ['id'])
        .order('nome')
        .map((dados) => dados.map((mapa) => Jogador.fromMap(mapa)).toList());
  }
}
