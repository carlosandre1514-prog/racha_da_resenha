import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:racha_da_resenha/models/jogador.dart';

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
