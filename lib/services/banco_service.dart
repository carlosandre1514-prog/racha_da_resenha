import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/jogador.dart';

class BancoService {
  // CONFIGURAÇÃO DO SEU BANCO ONLINE:
  // Cole abaixo a sua URL e a sua Chave que você copiou do site!
  static const String supabaseUrl = 'https://ylwfqdhozbhhlsjrcbvh.supabase.co';
  
  // ATENÇÃO: Apague o texto abaixo e cole a sua 'Publishable key' completa aqui dentro das aspas!
  static const String supabaseKey = 'COLE_AQUI_A_SUA_PUBLISHABLE_KEY_COMPLETA';

  // Inicializa a conexão com o servidor
  static Future<void> inicializar() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  final _client = Supabase.instance.client;

  // FUNÇÃO ONLINE 1: Mandar jogador novo para a nuvem
  Future<void> salvarJogadorNoBanco(Jogador jogador) async {
    await _client.from('jogadores').upsert(jogador.toMap());
  }

  // FUNÇÃO ONLINE 2: Ler todos os jogadores da nuvem em tempo real
  Stream<List<Jogador>> escutarJogadoresDoBanco() {
    return _client
        .from('jogadores')
        .stream(primaryKey: ['id'])
        .order('nome', ascending: true)
        .map((dados) => dados.map((mapa) => Jogador.fromMap(mapa)).toList());
  }

  // FUNÇÃO ONLINE 3: Atualizar apenas a presença (Switch) de um jogador
  Future<void> atualizarPresenca(String id, bool estaPresente) async {
    await _client.from('jogadores').update({'presente': estaPresente}).eq('id', id);
  }
}
