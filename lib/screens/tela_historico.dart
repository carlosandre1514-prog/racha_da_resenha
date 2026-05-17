import 'package:flutter/material.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista simulada de dados que futuramente virão direto da nuvem (Supabase)
    final List<Map<String, dynamic>> historicoExemplo = [
      {
        'data': '17/05/2026',
        'hora': '19:45',
        'campeao': 'Time 3',
        'pontos': '9',
        'vitorias': '3',
        'gols': '12',
      },
      {
        'data': '10/05/2026',
        'hora': '18:00',
        'campeao': 'Time 1',
        'pontos': '7',
        'vitorias': '2',
        'gols': '8',
      },
      {
        'data': '03/05/2026',
        'hora': '18:15',
        'campeao': 'Time 4',
        'pontos': '6',
        'vitorias': '2',
        'gols': '9',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Preto OLED
      body: historicoExemplo.isEmpty
          ? const Center(
              child: Text(
                "Nenhum racha registrado no histórico ainda.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: historicoExemplo.length,
              itemBuilder: (context, index) {
                final racha = historicoExemplo[index];

                return Card(
                  color: const Color(0xFF121212), // Fundo Grafite Escuro
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF39FF14), width: 0.5), // Borda Verde Neon
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    backgroundColor: const Color(0xFF121212),
                    collapsedBackgroundColor: const Color(0xFF121212),
                    iconColor: const Color(0xFFFFD700), // Ícone Amarelo ao abrir
                    collapsedIconColor: const Color(0xFF39FF14), // Ícone Verde fechado
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "📅 ${racha['data']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "🕒 ${racha['hora']}",
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            "🏆 CAMPEÃO: ",
                            style: TextStyle(
                              color: Color(0xFF39FF14), // Verde Neon
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            racha['campeao'].toString().toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFFFFD700), // Amarelo Ouro
                              fontWeight: FontWeight.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Detalhes que aparecem quando o usuário clica no Card do Histórico
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        color: const Color(0xFF1A1A1A), // Tom levemente mais claro
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CAMPANHA DO CAMPEÃO",
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _construirDadoEstatistica("Pontos", racha['pontos']),
                                _construirDadoEstatistica("Vitórias", racha['vitorias']),
                                _construirDadoEstatistica("Gols Marcados", racha['gols']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Color(0xFF39FF14), thickness: 0.3),
                            const SizedBox(height: 5),
                            Center(
                              child: TextButton.icon(
                                style: TextButton.styleFrom(foregroundColor: const Color(0xFF39FF14)),
                                icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                                label: const Text("Ver Tabela Completa Deste Dia"),
                                onPressed: () {
                                  // Futura lógica para abrir a tabela salva na nuvem
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _construirDadoEstatistica(String rótulo, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rótulo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
