import 'package:flutter/material.dart';

class TelaSorteio extends StatelessWidget {
  const TelaSorteio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista simulada de exemplo para ver o layout funcionando
    final Map<String, List<Map<String, String>>> timesExemplo = {
      'Time 1': [
        {'nome': 'Carlos (Goleiro)', 'tipo': 'goleiro'},
        {'nome': 'André', 'tipo': 'linha'},
        {'nome': 'Marquinhos', 'tipo': 'linha'},
        {'nome': 'Lucas', 'tipo': 'linha'},
      ],
      'Time 2': [
        {'nome': 'Chicão (Goleiro)', 'tipo': 'goleiro'},
        {'nome': 'Junior', 'tipo': 'linha'},
        {'nome': 'Felipe', 'tipo': 'linha'},
        {'nome': 'Mateus', 'tipo': 'linha'},
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: timesExemplo.keys.length,
              itemBuilder: (context, index) {
                String nomeTime = timesExemplo.keys.elementAt(index);
                var jogadores = timesExemplo[nomeTime]!;

                return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF39FF14), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        color: const Color(0xFF1A1A1A),
                        child: Text(
                          nomeTime,
                          style: const TextStyle(
                            color: Color(0xFFFFD700), // Amarelo
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...jogadores.map((j) => ListTile(
                            leading: Icon(
                              j['tipo'] == 'goleiro' ? Icons.sports_mma : Icons.directions_run,
                              color: const Color(0xFF39FF14),
                            ),
                            title: Text(
                              j['nome']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
          // Botão para avançar pro campeonato todos contra todos
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39FF14), // Verde Neon
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Iniciando campeonato: Todos contra todos!")),
                  );
                },
                child: const Text(
                  "INICIAR CAMPEONATO 🏆",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
