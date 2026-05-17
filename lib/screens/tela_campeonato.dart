import 'package:flutter/material.dart';

class TelaCampeonato extends StatefulWidget {
  const TelaCampeonato({Key? key}) : super(key: key);

  @override
  State<TelaCampeonato> createState() => _TelaCampeonatoState();
}

class _TelaCampeonatoState extends State<TelaCampeonato> {
  // Estados do Placar
  int golsTimeA = 0;
  int golsTimeB = 0;
  String timeSelecionadoA = 'Time 1';
  String timeSelecionadoB = 'Time 2';

  // Lista de times para os espaços em branco (Dropdowns)
  final List<String> _timesLista = ['Time 1', 'Time 2', 'Time 3', 'Time 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PARTE SUPERIOR: CRONÔMETRO CENTRALIZADO
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF39FF14), width: 0.5),
              ),
              child: Column(
                children: [
                  const Text("TEMPO DE JOGO", style: TextStyle(color: Colors.white, fontSize: 12)),
                  const SizedBox(height: 5),
                  const Text(
                    "07:00", // Número grande em Amarelo para enxergar de longe
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow, color: Color(0xFF39FF14), size: 30),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.pause, color: Colors.amber, size: 30),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.red, size: 25),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),

            // PARTE CENTRAL: CHAVEAMENTO / SELEÇÃO DE PARTIDA
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "CHAVEAMENTO DA PARTIDA",
                    style: TextStyle(color: Color(0xFF39FF14), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Espaço em branco Time A
                      Expanded(
                        child: DropdownButton<String>(
                          value: timeSelecionadoA,
                          dropdownColor: const Color(0xFF121212),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          onChanged: (String? novo) => setState(() => timeSelecionadoA = novo!),
                          items: _timesLista.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        ),
                      ),
                      // Quadrado do Placar A
                      _construirQuadradoPlacar(golsTimeA, () => setState(() => golsTimeA++), () => setState(() { if(golsTimeA > 0) golsTimeA--; })),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("VS", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                      ),
                      
                      // Quadrado do Placar B
                      _construirQuadradoPlacar(golsTimeB, () => setState(() => golsTimeB++), () => setState(() { if(golsTimeB > 0) golsTimeB--; })),
                      // Espaço em branco Time B
                      Expanded(
                        child: DropdownButton<String>(
                          value: timeSelecionadoB,
                          dropdownColor: const Color(0xFF121212),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          onChanged: (String? novo) => setState(() => timeSelecionadoB = novo!),
                          items: _timesLista.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Resultado salvo! Classificação atualizada.")),
                        );
                      },
                      child: const Text("SALVAR RESULTADO", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

            // PARTE INFERIOR: TABELA DE CLASSIFICAÇÃO
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 25, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("TABELA DE CLASSIFICAÇÃO", style: TextStyle(color: Color(0xFF39FF14), fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF39FF14), width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DataTable(
                columnSpacing: 18,
                headingRowColor: MaterialStateProperty.all(const Color(0xFF1A1A1A)),
                columns: const [
                  DataColumn(label: Text('Time', style: TextStyle(color: Color(0xFFFFD700)))),
                  DataColumn(label: Text('P', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('V', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('E', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('D', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('GP', style: TextStyle(color: Colors.white))),
                ],
                rows: [
                  _construirLinhaTabela('Time 1', 3, 1, 0, 0, 3),
                  _construirLinhaTabela('Time 2', 1, 0, 1, 0, 1),
                  _construirLinhaTabela('Time 3', 1, 0, 1, 0, 1),
                  _construirLinhaTabela('Time 4', 0, 0, 0, 1, 0),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _construirQuadradoPlacar(int valor, VoidCallback inc, VoidCallback dec) {
    return GestureDetector(
      onTap: inc,
      onLongPress: dec,
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border.all(color: const Color(0xFF39FF14), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "$valor",
          style: const TextStyle(color: Color(0xFFFFD700), fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  DataRow _construirLinhaTabela(String time, int p, int v, int e, int d, int gp) {
    return DataRow(cells: [
      DataCell(Text(time, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("$p")),
      DataCell(Text("$v")),
      DataCell(Text("$e")),
      DataCell(Text("$d")),
      DataCell(Text("$gp")),
    ]);
  }
}
