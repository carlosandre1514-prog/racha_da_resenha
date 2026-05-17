import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/banco_service.dart';
import 'screens/tela_jogadores.dart';
import 'screens/tela_config.dart';
import 'screens/tela_sorteio.dart';
import 'screens/tela_campeonato.dart';
import 'screens/tela_historico.dart';

void main() async {
  // Garante que os componentes do Flutter carreguem antes do banco de dados
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o Supabase Online com as suas chaves configuradas
  await BancoService.inicializar();
  
  runApp(const RachaDaResenhaApp());
}

class RachaDaResenhaApp extends StatelessWidget {
  const RachaDaResenhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha da Resenha',
      debugShowCheckedModeBanner: false,
      
      // Definição da identidade visual: Preto OLED, Verde Neon e Amarelo Destaque
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000), // Fundo Preto OLED
        primaryColor: const Color(0xFF39FF14), // Verde Neon
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF39FF14), // Verde Neon para botões e switches
          secondary: Color(0xFFFFD700), // Amarelo para destaques e estrelas
          surface: Color(0xFF121212), // Fundo de cards (Preto Grafite)
        ),
        textTheme: GoogleFonts.ubuntuTextTheme(ThemeData.dark().textTheme).copyWith(
          bodyLarge: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Color(0xFFBBBBBB)),
        ),
      ),
      home: const TelaPrincipalNav(),
    );
  }
}

class TelaPrincipalNav extends StatefulWidget {
  const TelaPrincipalNav({Key? key}) : super(key: key);

  @override
  State<TelaPrincipalNav> createState() => _TelaPrincipalNavState();
}

class _TelaPrincipalNavState extends State<TelaPrincipalNav> {
  int _telaSelecionadaIndex = 0;

  // Lista de telas que ficarão acessíveis pelo menu lateral
  final List<Widget> _telas = [
    const TelaJogadores(),
    const TelaConfig(),
    const TelaSorteio(),
    const TelaCampeonato(),
    const TelaHistorico(),
  ];

  final List<String> _titulos = [
    'Jogadores do Grupo',
    'Configurar Racha',
    'Times Sorteados',
    'Campeonato ao Vivo',
    'Histórico de Rachas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titulos[_telaSelecionadaIndex],
          style: TextStyle(
            color: Theme.of(context).primaryColor, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(color: Color(0xFF39FF14)), // Ícone do menu em verde
      ),
      
      // Menu Lateral customizado com as cores do Racha da Resenha
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF000000), // Fundo do menu preto
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF121212),
                  border: Border(bottom: BorderSide(color: Color(0xFF39FF14), width: 1)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚽ Racha da Resenha',
                      style: TextStyle(
                        color: Color(0xFF39FF14),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Painel Coletivo Online',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ),
              _criarItemMenu(0, '👥 Gerenciar Grupo', context),
              _criarItemMenu(1, '⚙️ Configurar Partida', context),
              _criarItemMenu(2, '🎲 Sorteio Atual', context),
              _criarItemMenu(3, '🏆 Campeonato', context),
              _criarItemMenu(4, '📅 Histórico Geral', context),
            ],
          ),
        ),
      ),
      body: _telas[_telaSelecionadaIndex],
    );
  }

  Widget _criarItemMenu(int index, String titulo, BuildContext context) {
    bool selecionado = _telaSelecionadaIndex == index;
    return ListTile(
      title: Text(
        titulo,
        style: TextStyle(
          color: selecionado ? const Color(0xFFFFD700) : Colors.white, // Amarelo se selecionado
          fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: selecionado ? const Color(0xFF121212) : Colors.transparent,
      onTap: () {
        setState(() {
          _telaSelecionadaIndex = index;
        });
        Navigator.pop(context); // Fecha o menu lateral
      },
    );
  }
}
